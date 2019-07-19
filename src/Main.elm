module Main exposing (..)

import Browser
import Html exposing (Html, text, div, h1, h2, img, ul, li, button)
import Html.Attributes exposing (src, class, width, height, style)
import Html.Events exposing (onClick)
import Http exposing (..)
import Json.Decode exposing (..)


---- MODEL ----


type alias Model =
    { selectedFruit : Fruit
    }


init : ( Model, Cmd Msg )
init =
    ({ selectedFruit = Fruit "Apple" 1 "Delicious Fruit" "https://upload.wikimedia.org/wikipedia/commons/0/07/Honeycrisp-Apple.jpg"
    }, Cmd.none )


type alias Fruit =
    { name : String
    , price : Int
    , description : String
    , image : String
    }

---- UPDATE ----


type Msg
    = SelectFruit Fruit
    | UpdateFruitList -- peticion
    | GotFruitList (Result Http.Error (List Fruit)) -- retorno


getListFruits : Cmd Msg
getListFruits =
    Http.get
    {    url = "localhost:3000"
    ,    expect = Http.expectJson (GotFruitList jsonDecodeFruits)  }

jsonDecodeFruits : Decoder (List Fruit)
jsonDecodeFruits =
    list decodeFruits

decodeFruits : Decoder Fruit
decodeFruits =
    map4 Fruit
        (field "name" string)
        (field "price" int)
        (field "description" string)
        (field "image" string)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SelectFruit fruit -> ( { model | selectedFruit = fruit }, Cmd.none )
        UpdateFruitList -> ( model, Cmd.none)
        GotFruitList list_fruits -> ( model, Cmd.none)

fruit_list : List Fruit
fruit_list = 
    [   Fruit "Apple" 1 "Delicious Fruit" "https://upload.wikimedia.org/wikipedia/commons/0/07/Honeycrisp-Apple.jpg"
    ,   Fruit "Banana" 2 "yellow Fruit" "https://upload.wikimedia.org/wikipedia/commons/8/8a/Banana-Single.jpg"
    ]

---- VIEW ----

getColour : Model -> Fruit -> String
getColour model fruit =
    if model.selectedFruit == fruit then
        "black"
    else 
        "white"

view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Fruit store" ]
        , ul [] 
            (List.map (\el ->
                let
                    el_text = el.name  ++ " " ++ (String.fromInt el.price)
                in
                li [ style "border" ("solid 1px " ++ (getColour model el)), style "width" "200px", onClick (SelectFruit el)] 
                    [ div [] [ text el_text ]
                    , img [ src el.image, width 200, height 200 ] []]
            ) fruit_list)
        , button [ onClick UpdateFruitList ] [ text "update"]
        ]

---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
