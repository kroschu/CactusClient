module TestApiUtils exposing (..)

import ApiUtils exposing (clientEndpoint, matrixDotToUrl, mediaEndpoint, thumbnailFromMxc)
import Expect exposing (Expectation)
import Test exposing (..)
import Url.Builder


testClientEndpoint : Test
testClientEndpoint =
    describe "Test clientEndpoint"
        [ test "sync endpoint" <|
            \_ ->
                clientEndpoint "https://matrix.org" [ "sync" ] []
                    |> Expect.equal "https://matrix.org/_matrix/client/r0/sync"
        , test "joined members endpoint" <|
            \_ ->
                clientEndpoint "https://matrix.org" [ "rooms", "#roomalias:matrix.org", "joined_members" ] []
                    |> Expect.equal "https://matrix.org/_matrix/client/r0/rooms/%23roomalias%3Amatrix.org/joined_members"
        , test "register guest endpoint" <|
            \_ ->
                clientEndpoint "https://matrix.org" [ "register" ] [ Url.Builder.string "kind" "guest" ]
                    |> Expect.equal "https://matrix.org/_matrix/client/r0/register?kind=guest"
        ]


testMediaEndpoint : Test
testMediaEndpoint =
    describe "Test mediaEndpoint"
        [ test "media download endpoint" <|
            \_ ->
                mediaEndpoint "https://matrix.org" [ "download", "matrix.example.com", "SEsfnsuifSDFSSEF" ] []
                    |> Expect.equal "https://matrix.org/_matrix/media/r0/download/matrix.example.com/SEsfnsuifSDFSSEF"
        ]


testMatrixDotToUrl : Test
testMatrixDotToUrl =
    describe "Test matrixDotToUrl"
        [ test "Make matrix.to user link" <|
            \_ ->
                matrixDotToUrl "@asbjorn:olli.ng"
                    |> Expect.equal "https://matrix.to/#/%40asbjorn%3Aolli.ng"
        , test "Make matrix.to room alias" <|
            \_ ->
                matrixDotToUrl "#roomAlias:matrix.org"
                    |> Expect.equal "https://matrix.to/#/%23roomAlias%3Amatrix.org"
        ]


testThumbnailFromMxc : Test
testThumbnailFromMxc =
    describe "Test thumbnailFromMxc"
        [ test "Test user avatar" <|
            \_ ->
                thumbnailFromMxc "https://matrix.org" "mxc://olli.ng/sWMkCgSyfhXzCoqWqzImfrFO"
                    |> Expect.equal (Just "https://matrix.org/_matrix/media/r0/thumbnail/olli.ng/sWMkCgSyfhXzCoqWqzImfrFO?width=64&height=64&method=crop")
        ]
