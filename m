Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FB8C7EE32
	for <linux-security-module@archiver.kernel.org>; Tue, 30 May 2023 14:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbjE3OF6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 30 May 2023 10:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbjE3OF4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 30 May 2023 10:05:56 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C5FEA
        for <linux-security-module@vger.kernel.org>; Tue, 30 May 2023 07:05:54 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-106-Am8f-XMVN6K4UDEwCA02rg-1; Tue, 30 May 2023 15:05:51 +0100
X-MC-Unique: Am8f-XMVN6K4UDEwCA02rg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 30 May
 2023 15:05:48 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 30 May 2023 15:05:48 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Min-Hua Chen' <minhuadotchen@gmail.com>,
        Serge Hallyn <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>
CC:     "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] capabilities: use logical OR
Thread-Topic: [PATCH] capabilities: use logical OR
Thread-Index: AQHZkoCZLKnbYMsJn0ez1CCVI83RJq9y2m1A
Date:   Tue, 30 May 2023 14:05:48 +0000
Message-ID: <db536b16e33648fdb44629fc9c1c1afc@AcuMS.aculab.com>
References: <20230529225440.7315-1-minhuadotchen@gmail.com>
In-Reply-To: <20230529225440.7315-1-minhuadotchen@gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Min-Hua Chen <minhuadotchen@gmail.com>
> Sent: 29 May 2023 23:55
> 
> Use logical OR to fix the following sparse warnings:
> 
> security/commoncap.c:1358:41: sparse: warning: dubious: !x | y
> 
> No functional changes intended.

Except it will run just that teeny, weeny bit slower.

	David

> Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
> ---
>  security/commoncap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 0b3fc2f3afe7..b8e34f6204b2 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -1355,7 +1355,7 @@ int cap_task_prctl(int option, unsigned long arg2, unsigned long arg3,
>  			return commit_creds(new);
>  		}
> 
> -		if (((!cap_valid(arg3)) | arg4 | arg5))
> +		if (((!cap_valid(arg3)) || arg4 || arg5))
>  			return -EINVAL;
> 
>  		if (arg2 == PR_CAP_AMBIENT_IS_SET) {
> --
> 2.34.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

