<?hh //strict

namespace typesafetycli;

final class ExampleClient implements Client<Request, Response>
{

    public function send(Request $request) : Response
    {
    }

}
