<?php
class Email {
    private array|string $headers = "";
    private string $to = "";
    private string $subject = "";
    private string $message = "";
    private string $parameters = "";

    public function _construct(
        string $to,
        string $subject,
        string $message,
        string $parameters = "",
        array|string $headers = ""
    ) {
        $this->to = !empty($to) ? $to : "";
        $this->subject = !empty($subject) ? $subject : "";
        $this->message = !empty($message) ? $message : "";
        $this->parameters = !empty($parameters) ? $parameters : "";
        $this->headers = !empty($headers) ? $headers : "From: finchab@yahoo.com"."\r\n";
    }

    public function setTo(string $to) : void {
        $this->to = !empty($to) ? $to : "";
    }

    public function setSubject(string $subject) : void {
        $this->subject = !empty($subject) ? $subject : "";
    }

    public function setMessage(string $message) : void {
        $this->message = !empty($message) ? $message : "";
    }

    public function setHeaders(string $headers) : void {
        $this->headers = !empty($headers) ? $headers : "";
    }

    public function setParameters(string $parameters) : void {
        $this->parameters = !empty($parameters) ? $parameters : "";
    }

    public function setHeadersToHtml() {
        $this->headers = "MIME-Version: 1.0" . "\r\n"; 
        $this->headers .= "Content-type:text/html;charset=UTF-8" . "\r\n";
    }

    public function sendEmail() {
        mail(
            $this->to,
            $this->subject,
            $this->message,
            !empty($this->headers) ? $this->headers : "",
            !empty($this->parameters) ? $this->parameters : "",
        );
    }
}?>