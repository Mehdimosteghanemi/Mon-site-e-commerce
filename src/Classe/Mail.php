<?php

namespace App\Classe;

use Mailjet\Client;
use Mailjet\Resources;

class Mail
{
    private $api_key = 'ef2b228354597e6d2e3dd90150c4f95a';
    private $api_key_secret = '67aa0a0c84acb5a8ceeddd51c0d016da';

    public function send($to_email, $to_name, $subject, $content)
    {   
        $mj = new Client($this->api_key, $this->api_key_secret, true, ['version' => 'v3.1']);
        
        $body = [
            'Messages' => [
                [
                    'From' => [
                        'Email' => "mapetiteboutique@yopmail.com",
                        'Name' => "Mailjet Pilot"
                    ],
                    'To' => [
                        [
                            'Email' => $to_email,
                            'Name' => $to_name
                        ]
                    ],
                    'TemplateID' => 3394881,
                    'TemplateLanguage' => true,
                    'Subject' => $subject,
                    'Variables' => [
                        'content' => $content
                    ]
                ]
            ]
        ];

        $response = $mj->post(Resources::$Email, ['body' => $body]);
        $response->success() && dd($response->getData());

    }
}