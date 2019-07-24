module Main exposing (..)

import Browser
import Html exposing (Html, text, div, h1, h2, img, ul, li, button)
import Html.Attributes exposing (src, class, width, height, style)
import Html.Events exposing (onClick)
import Http exposing (..)
import Json.Decode exposing (..)


---- MODEL ----


type alias Model =
    { fruitList : (List Fruit)
    , selectedFruit : String
    }


init : ( Model, Cmd Msg )
init =
    (
    { fruitList = []
    , selectedFruit = ""
    }, getListFruits )


type alias Fruit =
    { name : String
    , price : Float
    , description : String
    , image : String
    }

---- UPDATE ----


type Msg
    = UpdateFruitList -- peticion
    | GotFruitList (Result Http.Error (List Fruit)) -- retorno
    | SelectFruit String


getListFruits : Cmd Msg
getListFruits =
    Http.get
    {    url = "http://localhost:3000"
    ,    expect = Http.expectJson GotFruitList jsonDecodeFruits  }

jsonDecodeFruits : Decoder (List Fruit)
jsonDecodeFruits =
    Json.Decode.at["products"] <|
    list decodeFruits

decodeFruits : Decoder Fruit
decodeFruits =
    map4 Fruit
        (field "name" string)
        (field "price" float)
        (field "description" string)
        (field "image" string)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateFruitList -> ( model, getListFruits )
        GotFruitList result -> 
            case result of
                Result.Ok value -> ( { model | fruitList = value } , Cmd.none)
                Result.Err _ -> ( model, Cmd.none)
        SelectFruit value -> ({ model | selectedFruit = value}, Cmd.none)

fruit_list : List Fruit
fruit_list = 
    [   Fruit "Apple" 1 "Delicious Fruit" "https://upload.wikimedia.org/wikipedia/commons/0/07/Honeycrisp-Apple.jpg"
    ,   Fruit "Banana" 2 "yellow Fruit" "https://upload.wikimedia.org/wikipedia/commons/8/8a/Banana-Single.jpg"
    ]

---- VIEW ----

getColour : Model -> Fruit -> String
getColour model fruit =
    if fruit.name == model.selectedFruit then  
        "black"
    else
        "white"


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Fruit store" ]
        , div [][ text "cccc"]
        , ul [] 
            (List.map (\el ->
                let
                    el_text = el.name
                in
                li [ style "border" ("solid 1px " ++ (getColour model el)), style "width" "200px", onClick (SelectFruit el.name) ] 
                    [ div [] [ text el_text ]
                    , img [ src el.image, width 200, height 200 ] []]
            ) model.fruitList)
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
