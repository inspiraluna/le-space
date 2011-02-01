package le.space

class DoorController {

    def open = {
        log.debug " rest call from ${params.phoneNumber} to POST (open) with params ${params}"

        //query user with telephone number
        //check if user paid (login service!?)

        render "open"
    }
}
