Return-Path: <SRS0=p2Kc=SF=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC53EC10F0B
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Apr 2019 13:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4CD21734
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Apr 2019 13:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ssi.gouv.fr header.i=@ssi.gouv.fr header.b="EATfNl9y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfDCNXw (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:23:52 -0400
Received: from smtp-out.ssi.gouv.fr ([86.65.182.90]:57224 "EHLO
        smtp-out.ssi.gouv.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfDCNXw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 3 Apr 2019 09:23:52 -0400
X-Greylist: delayed 353 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Apr 2019 09:23:51 EDT
Received: from smtp-out.ssi.gouv.fr (localhost [127.0.0.1])
        by smtp-out.ssi.gouv.fr (Postfix) with ESMTP id 5E10BD00072;
        Wed,  3 Apr 2019 15:18:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ssi.gouv.fr;
        s=20160407; t=1554297484;
        bh=YKKGEguUCXnMvqAL7/fwk57lvfoTzNlmuHMXcNpqyqw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From:Subject;
        b=EATfNl9ynZgsVo+UDf1KS+DqPBGL2FAu2UwK5mxfMqIDRjkq+Qso8HJtArhyoouFa
         NlNJLmW/Zs5YGnT5kozzjAv5vn7ZeIi4RmPP96QqZ5OIKMbmV4e0rz3N3kBzAXtwGj
         VMFsEHUt4guEX9EkqXmrGNdBca/jnSKTE6JpOMCb6hx42gMDSf7BGi0hDEi9OLFWhP
         tzrVQlaxO1DxK4q1nOIeMnGRP7K5hNXIs+OKCyNQTSlASETm9Zvu2pcVZ9uq/D4KOq
         rqOJgypyVfCTe6wOaH/ojiL4N6RIIuIK7ytQZHQeUwtoJMNT4wCET7eNBWkSH4rvlT
         gfKBKed2owaaQ==
Subject: Re: Should mprotect(..., PROT_EXEC) be checked by IMA?
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Matthew Garrett <mjg59@google.com>,
        Igor Zhbanov <i.zhbanov@omprussia.ru>
CC:     Stephen Smalley <sds@tycho.nsa.gov>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mickael.salaun@ssi.gouv.fr>,
        Yves-Alexis Perez <corsac@corsac.net>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
References: <cce2c4c7-5333-41c3-aeef-34d43e63acb0@omprussia.ru>
 <1552945715.8658.299.camel@linux.ibm.com>
 <452752df-98f9-c361-878a-5df84ab36847@omprussia.ru>
 <1552994559.4899.26.camel@linux.ibm.com>
 <84145490-6f70-214f-8241-42d556590240@omprussia.ru>
 <1553015134.4899.82.camel@linux.ibm.com>
 <a9830bde-8157-6078-b544-fcffb20d2501@omprussia.ru>
 <CACdnJut6YfLnq-nCC1hHTrKYXabHoSEXN1wMuCyVybU+o_iwCg@mail.gmail.com>
 <1553167318.4899.382.camel@linux.ibm.com>
 <dab923ca-ef53-4af2-034a-bea4151a4e25@omprussia.ru>
 <CACdnJuvVqibDdd+MLKOHqEfdngTk=GSkfybj1jS3MpmC7rjyHg@mail.gmail.com>
 <07347317-ee71-83c1-384a-0c3439980af7@omprussia.ru>
 <1553793463.8711.26.camel@linux.ibm.com>
 <92718382-8669-748f-10d8-02fa21225210@omprussia.ru>
 <1553857187.9420.49.camel@linux.ibm.com>
 <b5a89692-4c93-80b3-37e5-41265765cdc3@tycho.nsa.gov>
 <cb46d5ba-30de-664f-67d4-646da4592a6f@omprussia.ru>
 <CACdnJusPpis1JJgfNOrQoqPcVk0q2OGbosrXOVtZmG0cSqkotw@mail.gmail.com>
 <1554293478.7309.54.camel@linux.ibm.com>
From:   Perez Yves-Alexis <yves-alexis.perez@ssi.gouv.fr>
Openpgp: preference=signencrypt
Autocrypt: addr=yves-alexis.perez@ssi.gouv.fr; prefer-encrypt=mutual; keydata=
 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
Message-ID: <1d8264fb-495b-3b68-0192-0338247e6b54@ssi.gouv.fr>
Date:   Wed, 3 Apr 2019 15:18:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <1554293478.7309.54.camel@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: fr-FR
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Le 03/04/2019 =C3=A0 14:11, Mimi Zohar a =C3=A9crit :
> On Tue, 2019-04-02 at 15:31 -0700, Matthew Garrett wrote:
>> On Fri, Mar 29, 2019 at 5:50 AM Igor Zhbanov <i.zhbanov@omprussia.ru> wr=
ote:
>>> I want to be sure that no unsigned code page could be executed. So expl=
oits
>>> could only be of ROP kind and not being able to download any extra code
>>> from their servers. That's why I found that disabling of anonymous exec=
utable
>>> pages could be useful for that (as well as disabling of making executab=
le
>>> pages writable to modify already mapped code). In conjunction with IMA =
it
>>> should guarantee that no untrusted code could be executed.
>>
>> Remember that many interpreted languages allow execution of code
>> provided to them on the command line (eg, python -c) and also grant
>> access to arbitrary syscalls, so there's still no guarantee that
>> you're only executing trusted code.
>
> Interpreters are a known concern, as Yves-Alexis Perez pointed out in
> his LSS-2018 Europe talk[1].
>
> Mimi
>
> [1]=C2=A0https://events.linuxfoundation.org/wp-content/uploads/2017/12/Li=
nu
> x-Kernel-Security-Contributions-by-ANSSI-Yves-Alexis-Perez-ANSSI.pdf
>
And Micka=C3=ABl Sala=C3=BCn posted the O_MAYEXEC patch RFC back in Decembe=
r
(https://lore.kernel.org/lkml/20181212081712.32347-1-mic@digikod.net/)

Regards,
--
Yves-Alexis Perez
ANSSI/SDE/ST/LAM
Les donn=C3=A9es =C3=A0 caract=C3=A8re personnel recueillies et trait=C3=A9=
es dans le cadre de cet =C3=A9change, le sont =C3=A0 seule fin d=E2=80=99ex=
=C3=A9cution d=E2=80=99une relation professionnelle et s=E2=80=99op=C3=A8re=
nt dans cette seule finalit=C3=A9 et pour la dur=C3=A9e n=C3=A9cessaire =C3=
=A0 cette relation. Si vous souhaitez faire usage de vos droits de consulta=
tion, de rectification et de suppression de vos donn=C3=A9es, veuillez cont=
acter contact.rgpd@sgdsn.gouv.fr. Si vous avez re=C3=A7u ce message par err=
eur, nous vous remercions d=E2=80=99en informer l=E2=80=99exp=C3=A9diteur e=
t de d=C3=A9truire le message. The personal data collected and processed du=
ring this exchange aims solely at completing a business relationship and is=
 limited to the necessary duration of that relationship. If you wish to use=
 your rights of consultation, rectification and deletion of your data, plea=
se contact: contact.rgpd@sgdsn.gouv.fr. If you have received this message i=
n error, we thank you for informing the sender and destroying the message.
