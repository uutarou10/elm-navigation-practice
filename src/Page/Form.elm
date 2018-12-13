module Page.Form exposing (Model, Msg(..), init, update, view)

import Browser
import Html exposing (..)
import Html.Events exposing (..)


init : Model
init =
    { input = "" }


type alias Model =
    { input : String }


view : Model -> Browser.Document Msg
view model =
    { title = "about"
    , body =
        [ h1 [] [ text "About" ]
        , input [ onInput Input ] []
        ]
    }


type Msg
    = Input String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )
