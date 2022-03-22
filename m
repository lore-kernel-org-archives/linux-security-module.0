Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7899CC433EF
	for <linux-security-module@archiver.kernel.org>; Tue, 22 Mar 2022 19:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiCVTb6 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 22 Mar 2022 15:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiCVTb6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 22 Mar 2022 15:31:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DDA87938A
        for <linux-security-module@vger.kernel.org>; Tue, 22 Mar 2022 12:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647977428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V5V/hUtU1eWPYAfu3Vkm3R/UNQxwyoHX973gqDqsE8I=;
        b=FYZPx3PShsAaApuk8DFuWpRZWgrzgFm4+sMmnEAt29joSEgg76ZPa81d3Z7pFllZuv+D0u
        bX4owp6zDPvAN91pDXIN16OB1+NM0uCPJpByWWdPc+VOLWYAJ6a8YCkWsaEfx6I0PdU7EE
        QGeqNEaVbPn1IkSiApBB4arCK+3jO7k=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-457-ahcJeTQsO_6_aBwy3t2WBw-1; Tue, 22 Mar 2022 15:30:26 -0400
X-MC-Unique: ahcJeTQsO_6_aBwy3t2WBw-1
Received: by mail-qk1-f197.google.com with SMTP id i2-20020a05620a248200b0067b51fa1269so12446894qkn.19
        for <linux-security-module@vger.kernel.org>; Tue, 22 Mar 2022 12:30:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V5V/hUtU1eWPYAfu3Vkm3R/UNQxwyoHX973gqDqsE8I=;
        b=uVC5w3wcmKW7O0iOq21qiN/mAPrtJSe1d+Rsw/RxSQd3edEbN4n15Q3eEcCmhq4KsX
         aD+vkH3P3JHwh4TmhgfVEu2vFG7SigOaqKN8nnFOKQF5fT2bgWhc+UXUDRsQgwmHWB/B
         PMq9g669EY3g8ahDGOtKOdYybD4BDFxJPtmfeIiAqduIljdUkR2NudEhiAwT1CiU1zgh
         OyK8RiBF5b4NiJzEfakwJPRO7LULmPNaIsdBZM8sheZmjUOGjJmVB1rd+tN2YaEs0zlZ
         fbfQZbOTTazzmYw+6wsCymGUkOFDsl0OsHvN6oSffKBV14j4Yg2juk5otuJCEaiC9bUK
         tTIg==
X-Gm-Message-State: AOAM531RbqlmFZwYse4Gn4Tyfsd5bwXZjAWKyfSmKNvXyLqMIl/v4Zp1
        bkQVa+RW587b9b4I82Qzju+0zNX7mU54rVvLTn2aK1jw+72T7naeYJvLJnXByeCY25nDk67Z8bZ
        E85IlYEp7q5sUAXw1/VnktXiUKG1x0hVqCs4gsPnZ0YMIJ7NcXRm4
X-Received: by 2002:a05:620a:c46:b0:67e:1559:559a with SMTP id u6-20020a05620a0c4600b0067e1559559amr16097364qki.437.1647977426251;
        Tue, 22 Mar 2022 12:30:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+VQun41HDweR1Q6kFjVMaBNO1gZRC3yTuomyULbugtJxnjMIxasm8DtUv+co5J5RPeBaDxYQKjXqd654EoCw=
X-Received: by 2002:a05:620a:c46:b0:67e:1559:559a with SMTP id
 u6-20020a05620a0c4600b0067e1559559amr16097353qki.437.1647977426061; Tue, 22
 Mar 2022 12:30:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220322192712.709170-1-mszeredi@redhat.com>
In-Reply-To: <20220322192712.709170-1-mszeredi@redhat.com>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Tue, 22 Mar 2022 20:30:15 +0100
Message-ID: <CAOssrKcJT=HCYW1tUwUaZbD8gi2CNh4__7Q6kqTPsdxF07dmBQ@mail.gmail.com>
Subject: Re: [RFC PATCH] getvalues(2) prototype
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mszeredi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed; boundary="000000000000148ba905dad3a5c2"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

--000000000000148ba905dad3a5c2
Content-Type: text/plain; charset="UTF-8"

On Tue, Mar 22, 2022 at 8:27 PM Miklos Szeredi <mszeredi@redhat.com> wrote:
>
> Add a new userspace API that allows getting multiple short values in a
> single syscall.

Attaching a test program that allows arbitrary queries.

Thanks,
Miklos

--000000000000148ba905dad3a5c2
Content-Type: text/x-csrc; charset="US-ASCII"; name="getvalues.c"
Content-Disposition: attachment; filename="getvalues.c"
Content-Transfer-Encoding: base64
Content-ID: <f_l12j71mq0>
X-Attachment-Id: f_l12j71mq0

I2luY2x1ZGUgPHVuaXN0ZC5oPgojaW5jbHVkZSA8c3RyaW5nLmg+CiNpbmNsdWRlIDxzdGRpby5o
PgojaW5jbHVkZSA8ZmNudGwuaD4KI2luY2x1ZGUgPGVyci5oPgojaW5jbHVkZSA8c3RkaW50Lmg+
CiNpbmNsdWRlIDxzeXMvdWlvLmg+CgpzdHJ1Y3QgbmFtZV92YWwgewoJY29uc3QgY2hhciAqbmFt
ZTsJLyogaW4gKi8KCXN0cnVjdCBpb3ZlYyB2YWx1ZV9pbjsJLyogaW4gKi8KCXN0cnVjdCBpb3Zl
YyB2YWx1ZV9vdXQ7CS8qIG91dCAqLwoJdWludDMyX3QgZXJyb3I7CQkvKiBvdXQgKi8KCXVpbnQz
Ml90IHJlc2VydmVkOwp9OwoKCmludCBnZXR2YWx1ZXMoaW50IGRmZCwgY29uc3QgY2hhciAqcGF0
aCwgc3RydWN0IG5hbWVfdmFsICp2ZWMsIHNpemVfdCBudW0sCgkgICAgICB1bnNpZ25lZCBpbnQg
ZmxhZ3MpCnsKCXJldHVybiBzeXNjYWxsKDQ1MSwgZGZkLCBwYXRoLCB2ZWMsIG51bSwgZmxhZ3Mp
Owp9CgppbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQp7CgljaGFyICpzLCBidWZbNDA5
Nl07CglpbnQgcmVzLCBpLCBvLCBudW0gPSBhcmdjIC0gMjsKCXN0cnVjdCBuYW1lX3ZhbCBudnNb
MjU2XSA9IHt9OwoKCWlmIChhcmdjIDwgMykKCQllcnJ4KDEsICJ1c2FnZTogJXMgcGF0aCBuYW1l
IFsuLi5dIiwgYXJndlswXSk7CglpZiAobnVtID4gMjU2KQoJCWVycngoMSwgInRvbyBtYW55IGFy
Z3VtZW50cyIpOwoKCWZvciAoaSA9IDA7IGkgPCBudW07IGkrKykKCQludnNbaV0ubmFtZSA9IGFy
Z3ZbaSArIDJdOwoKCW52c1swXS52YWx1ZV9pbi5pb3ZfYmFzZSA9IGJ1ZjsKCW52c1swXS52YWx1
ZV9pbi5pb3ZfbGVuID0gc2l6ZW9mKGJ1Zik7CgoJcmVzID0gZ2V0dmFsdWVzKEFUX0ZEQ1dELCBh
cmd2WzFdLCBudnMsIG51bSwgMCk7CglpZiAocmVzID09IC0xKQoJCWVycigxLCBOVUxMKTsKCglu
dW0gPSByZXM7Cglmb3IgKGkgPSAwOyBpIDwgbnVtOyBpKyspIHsKCQlwcmludGYoIlslc10gPSAi
LCBudnNbaV0ubmFtZSk7CgkJcmVzID0gbnZzW2ldLmVycm9yOwoJCWlmIChyZXMpIHsKCQkJcHJp
bnRmKCIgRVJST1I6ICVzICglaSlcbiIsIHN0cmVycm9yKHJlcyksIHJlcyk7CgkJfSBlbHNlIHsK
CQkJcmVzID0gbnZzW2ldLnZhbHVlX291dC5pb3ZfbGVuOwoJCQlzID0gbnZzW2ldLnZhbHVlX291
dC5pb3ZfYmFzZTsKCgkJCWZvciAobyA9IDA7IG8gPCByZXM7IG8gKz0gc3RybGVuKHMgKyBvKSAr
IDEpCgkJCQlwcmludGYoIlwiJS4qc1wiICIsIHJlcyAtIG8sIHMgKyBvKTsKCgkJCXByaW50Zigi
KGxlbj0laSlcbiIsIHJlcyk7CgkJfQoJfQoJcmV0dXJuIDA7Cn0K
--000000000000148ba905dad3a5c2--

