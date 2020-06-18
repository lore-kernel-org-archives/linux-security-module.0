Return-Path: <SRS0=g/MA=77=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456D2C433E1
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Jun 2020 06:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24EB32186A
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Jun 2020 06:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LvLtQrHK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgFRGm5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 18 Jun 2020 02:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727853AbgFRGm4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 18 Jun 2020 02:42:56 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBF3C0613EE
        for <linux-security-module@vger.kernel.org>; Wed, 17 Jun 2020 23:42:54 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id d21so712837lfb.6
        for <linux-security-module@vger.kernel.org>; Wed, 17 Jun 2020 23:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K6hCnmc25bPhM8Zds15z3T5k2ctR9P+E0kmH5eedao4=;
        b=LvLtQrHK+FRlk5/sD/8n+NvY5OlKXKDXtDGMvGAWEV8LStu+H5SMcJeof/D1Bi311E
         iG2SVk2aU8L6UtTvMM8QqgfobAoSZA/4MszA+QHc6H9+WyoduT5HIfL3NiYOClb4mgyQ
         sWSi05++HNZSaCzaYuMbRzFE/0UM0074HyCLCvUzrlUKp9M2DFy94o8jLGFyaPfQRSRB
         vUi6H6KpwDixktHDOVJdezLiS2MP8TfPZ1UtIASSqww607WvpGLOrH5fk+dmANcJlVEi
         LblDqZh3z5oDKbVxry/Q7EUNdmW19cHib1w0FFgAFPAmFzAtBbVtvd2OsQMdNed0x+IO
         CTaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K6hCnmc25bPhM8Zds15z3T5k2ctR9P+E0kmH5eedao4=;
        b=dTUdptZAcaXJhQ0KLP03ZXK0gGGBJnC5cZHCapuv2L8FgatSYKXO5xYV/aY751+vjF
         J+WF3VaZgljREswM7hIsEZLBn43ESnfilbwmjsCEW0dm5KTZVRdsbhdqa404QdQM6SNj
         uZZEnjF6sglGBxtyP//eGYmQvCXfS81Q41zMNv/3uEIQ5MGnNdc2ObRxseVjPEvpiK7U
         acD/b3qtkKVqswSub9KFiVS57a7oXuqI9XR+ukI+vTiyv2SiJ2qvWyOCZR8X/eX58MgT
         R/vawI4xn6+gXL7TjWMk5IQVLxa7GiOS3BNYftIwRZX+KpHi7r8eBad+M8B89Aiak/fP
         +Zsw==
X-Gm-Message-State: AOAM531XAGy5MDOnMNM3frz3ogTQprR3CkO6638PbkI4AZPzQGRzYS1Y
        In9tq8Uh1bH+KJByrA7IaNV2tKpvHEftnXJzYypSAw==
X-Google-Smtp-Source: ABdhPJx4QxcHzkbgPAk3c9tXd5/s0nYZNRG6j8i+HfERTJzJ+F0FGPMbAipjRTc9ukWM5DOXoFi2vtfz2V+2oSbLHwA=
X-Received: by 2002:ac2:41d4:: with SMTP id d20mr1489555lfi.204.1592462573264;
 Wed, 17 Jun 2020 23:42:53 -0700 (PDT)
MIME-Version: 1.0
References: <1591107505-6030-1-git-send-email-sumit.garg@linaro.org>
 <1591107505-6030-2-git-send-email-sumit.garg@linaro.org> <20200615182457.GB5416@linux.intel.com>
 <CAFA6WYNEnXm5FOGHGAg4XB-+GXD=C+YMh+6t976=pStU0WshAA@mail.gmail.com> <20200617231429.GD62794@linux.intel.com>
In-Reply-To: <20200617231429.GD62794@linux.intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 18 Jun 2020 12:12:41 +0530
Message-ID: <CAFA6WYOdtwnewqY0ASnMf7fyw3s_hQx0+oWJRhT3CpkkkxYpDA@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] KEYS: trusted: Add generic trusted keys framework
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Markus Wamser <Markus.Wamser@mixed-mode.de>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        op-tee@lists.trustedfirmware.org,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        Luke Hinds <lhinds@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 18 Jun 2020 at 04:44, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Tue, Jun 16, 2020 at 07:02:37PM +0530, Sumit Garg wrote:
> > + Luke
> >
> > Hi Jarkko,
> >
> > Prior to addressing your comments below which seems to show your
> > preference for compile time selection of trust source (TPM or TEE), I
> > would just like to hear the reasons for this preference especially if
> > it makes distro vendor's life difficult [1] to make opinionated
> > selection which could rather be achieved dynamically based on platform
> > capability.
> >
> > [1] https://lkml.org/lkml/2020/6/3/405
> >
> > -Sumit
>
> Hmm... I do get the distribution kernel point. OK, lets revert to
> dynamic then. Thanks for the remark.
>
> /Jarkko

Thanks, will revert to dynamic mode in v6.

-Sumit
