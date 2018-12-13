module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Browser.Navigation as Navigation
import Html exposing (..)
import Html.Attributes exposing (..)
import Url
import Url.Parser as Parser exposing ((</>))



---- MODEL ----


type alias Model =
    { url : Url.Url
    , key : Navigation.Key
    }


init : () -> Url.Url -> Navigation.Key -> ( Model, Cmd Msg )
init flags url key =
    ( Model url key, Cmd.none )



---- UPDATE ----


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChange Url.Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Navigation.pushUrl model.key <| Url.toString url )

                Browser.External url ->
                    ( model, Navigation.load url )

        UrlChange url ->
            ( { model | url = url }, Cmd.none )



---- NAVIGATION ----


type Route
    = Home
    | About
    | Counter
    | NotFound


parser : Parser.Parser (Route -> a) a
parser =
    Parser.oneOf
        [ Parser.map Home Parser.top
        , Parser.map About <| Parser.s "about"
        , Parser.map Counter <| Parser.s "counter"
        ]


parse : Url.Url -> Route
parse url =
    Maybe.withDefault NotFound <| Parser.parse parser url



---- VIEW ----


view : Model -> Browser.Document Msg
view model =
    case parse model.url of
        Home ->
            { title = "home"
            , body =
                [ text "home"
                , viewLinks
                ]
            }

        About ->
            { title = "about"
            , body =
                [ text "I am uutarou"
                , viewLinks
                ]
            }

        Counter ->
            { title = "counter"
            , body =
                [ text "counter"
                , viewLinks
                ]
            }

        NotFound ->
            { title = "not found"
            , body =
                [ text "not found"
                , viewLinks
                ]
            }


viewLinks : Html Msg
viewLinks =
    div []
        [ ul []
            [ li [] [ a [ href "/" ] [ text "/" ] ]
            , li [] [ a [ href "/about" ] [ text "/about" ] ]
            , li [] [ a [ href "/counter" ] [ text "/counter" ] ]
            ]
        ]



---- PROGRAM ----


main =
    Browser.application
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        , onUrlRequest = LinkClicked
        , onUrlChange = UrlChange
        }
