module Main exposing (main)

import Browser
import Browser.Navigation as Navigation
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Page.Form
import Url



-- Main


main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlRequest = LinkClicked
        , onUrlChange = UrlChanged
        }


init : () -> Url.Url -> Navigation.Key -> ( Model, Cmd Msg )
init flags url key =
    let
        -- TODO: Parseする
        page =
            Top
    in
    ( { key = key
      , page = page
      }
    , Cmd.none
    )



-- Model


type alias Model =
    { key : Navigation.Key
    , page : Page
    }


type Page
    = Top
    | Form Page.Form.Model



-- Update


type Msg
    = FormMsg Page.Form.Msg
    | UrlChanged Browser.UrlRequest
    | LinkClicked Url.Url


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        FormMsg msg ->
            case model.page of
                Form form ->
                    stepForm model (Page.Form.update msg form)

                _ ->
                    ( model, Cmd.none )

        UrlChanged url ->
            case url of
                Browser.Internal url ->
                    ( model, Navigation.pushUrl model.key )


stepForm : Model -> ( Page.Form.Model, Cmd Page.Form.Msg ) -> ( Model, Cmd Msg )
stepForm model ( form, cmds ) =
    ( { model | page = Form form }
    , Cmd.map FormMsg cmds
    )



-- View


view : Model -> Browser.Document Msg
view model =
    case model.page of
        Top ->
            { title = "top"
            , body = [ text "top page" ]
            }

        Form form ->
            { title = "top"
            , body = [ text "top page" ]
            }



-- Subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
