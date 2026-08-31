Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD783955F1
	for <linux-security-module@vger.kernel.org>; Mon, 31 Aug 2026 21:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788211709; cv=pass; b=GjfDy4Ehyj7hcJPB9WkSEe/o0x8M65q2mfZj2RlpY9hD0zMvXWu7hUFARm/+lZnZPKRrtMVWsjQGHHroVBBOy3IJBkzPSOMdLoSu1TeQd/NZWepp0SvPX7Obv7zJJl/B95lgJGd0r43Z3VLEQXEn8RVgNK2vwpZNXraFxZWp5Bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788211709; c=relaxed/simple;
	bh=bfNrL7XwYmUCxmPxgk5/2sdM6T6+oYFGe+D+rry6+yE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jp0Gqpj+sRhkUT0aj+M1HlaWyGYJn1PeNMPBPETkNq6qXBIClQu7fxnWVvCqVZ/oFGx9Dk7Kw7aN+nW491uCYWGscE+/ySUo0CtegMpd68ccI5/wUd0BdlojUkYL9snokw/5ZjjPuv9Al51PeoH62kVX/jj1sZO8xPhOSqSDMFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SJyJQ7Jq; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SJyJQ7Jq"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d01663d816so967405ad.1
        for <linux-security-module@vger.kernel.org>; Mon, 31 Aug 2026 14:28:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788211706; cv=none;
        d=google.com; s=arc-20260327;
        b=h8KT3w/I/SkYwsbuq1BO8wJfWAniNKgvvJx74DZ5bTmQtKCDDi2olAczWISuzd2ge9
         xMAZK2GWyMiZPLSQaR7mydanEUQVvEXfhMX0qB3tcfJeCjCUYXBsGaytyGs4tSO1VpDn
         FQZD28oCOp+b7DSyU9bOCh+jZ3W0Hhss+bvZSvB5cyjyMHRo+qn3bnNm17eouOfxhsC4
         a1h02BBbuvixPhLTdDn+JgT2jGtpMfjTO4Kdy+pCl+K7KLQXkyKb5jnXsN42WFBOJ515
         5QkNMsXSGUXNZL4NOUOIj05crfUEIZ/5UylrWTDaWqplfVtd1S72F84H0U/f2p4Sr0TB
         fblg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JsoDZnDnnjuhIjWwApu8K5QF0OsufRvTAlRhz2feA9k=;
        fh=zXLpA7YpfX43dWIdoSaPkQA0hGa2NZ0k8isn9Wvgqp4=;
        b=sL/9XY3O1L2FK2wAOq/F+DJTJ2TLKeTI8HPBx/0jNksWw9TIOlxn98dNie6e6SV6NJ
         lRQ/Gzt+xQdJOUzfDDKvSUK0wSMd+Dq7yLJc+YegoAA/chUhU7g+RMgvH7DU5IdPxNIy
         +IOkWNOWCUZi/tZk+gS+J51gluh62LBSZF5O5/jf1vZ+qoRXomRX3FJHJKAPrLR0yaWA
         JDrr3DiTpChl2HLyoJuKl1xfDxK5MuDT03SL/zhlDt4xyVPkOfVz6LIOSsyhiR3ARao4
         59uR/whgx3Pwaj4mlB4E4aS3Up+T0roM4CQO5oiGhVGWSTUpe+IqYhBasDTtVDpwLySl
         z+gQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788211706; x=1788816506; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JsoDZnDnnjuhIjWwApu8K5QF0OsufRvTAlRhz2feA9k=;
        b=SJyJQ7JqrE7TcZPzOXt3OLwon7pelFjylGTAKsvrlf9it4Lyk5/yQthvO65CaJBr8b
         fVw58+kZrXoFtB8lydFCMsQkPaytpvw8CD9pSLLLwdve+d0rrcWZYPPWjg2iRFv/abK8
         wxjJnh743h9/+69fHMye5YnHqWLauxu3kscsWLdpV4OMbPoDq3eLEBQNVAsQA65CKrbS
         aYSiSGdjdF4iqDU6pS+QW664RjQjsX58jnzYtitV5OMr1Fku8HbW8weDhQXJWW/dJpw2
         YNOF8x/e0J1XJ+Cx1my9wtZEg1zFmjMf9GahQAsBIGm8+EqKcac4HFmYjejyTIXZjcDn
         eQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788211706; x=1788816506;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JsoDZnDnnjuhIjWwApu8K5QF0OsufRvTAlRhz2feA9k=;
        b=OHAdpK9AklKpVAULOCect6jtxUuhIoa5pCc6uJXwcwmNfpE2/jI9FfATNwStO+loNq
         MTFyp8rb7q+UqQt0y11ksOjwbir9KA0AQZZ1m1bc8sphug6D8XFx43OWKi+WVQlGDZFu
         fCmZQ9zURUrmVX7I6cDzFQ28/ny4XqCH2c2fXe51zIqs7oV4HXd8ZecJFY8CFMysdDUc
         lJC9klgvMWr9CmIZlnGsKUbU/2oAN/l98VWpDsMg+N0IoNJ3mtY96iv19zhR7D8qVcxV
         +Vzaexhfe8FQ9Vl3/QbAwoSe4FL2ro/1FjW3g7TKeKFWOTmOFZg7wUMhhSJ7uJPfhIYU
         ptTQ==
X-Gm-Message-State: AFuF++nyAZh6cpPoo83oHizqI27sb2cZ+B04bj5nxO4/Ws7SAOxAGkMU
	Q7TAM+VYc6UbIOfJBRXZC+x9etLGcAEg9Gfj2ryUOM9ep/NojZvsG+UQR1AooGwYK4R/G5NNNdV
	Dwip2pu8LfBtRds5ieGLmVW4i+WudxxLHXnIIYVJeU8h2ywPMVdBpiQ==
X-Gm-Gg: AYBFou3tc0oUbY+gr5X0Gxib+58Gh0a9HL9IGw2Ie5U9//TyCgyTjGrrZLD3SLJsO0u
	sehbccfpbwyemRM6ObQQpErSWv1EAbLIszxhALtKMXsoFXxSft1LITkDZTLQv9fHKyxsB2FpTc3
	PwYIJpo8aftANlgIGyjMa8ZLxpAtFSjcrmKZD9U+scwKzgpWvpvqRriXLVKBlK4UMe2OSoJg+WX
	4rMBvjXoIyhj82XljS9hqt/fvzFCqj0gFOZpC5THniGe2N82H9EsHxjlG3MRBQ98wzypwhSItkk
	fKDjuQdTbYNBdAA+7uiHZk24v0UPzhv+MblCj1k0jO+C
X-Received: by 2002:a17:902:be02:b0:2d8:d4ce:9f37 with SMTP id
 d9443c01a7336-2d8d4cea3c8mr206776655ad.21.1788211705902; Mon, 31 Aug 2026
 14:28:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707080615.1235830-2-caixinchen1@huawei.com> <e94ebd7547b7c28a7caaf6948d3d4953@paul-moore.com>
In-Reply-To: <e94ebd7547b7c28a7caaf6948d3d4953@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 31 Aug 2026 17:28:14 -0400
X-Gm-Features: AcwNN1VUodnldawlS_uqwoK_0s9F_ptNR9NaT6eAmgzNXN8aIg-3rz0MbKhy-Ec
Message-ID: <CAHC9VhQYZg1tuwBOqF3jw310U8SjhEvJn62zsFxbNNS4=MN19g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] security: Delete dumplicate assignment
To: Cai Xinchen <caixinchen1@huawei.com>, jmorris@namei.org, serge@hallyn.com, 
	amir73il@gmail.com, brauner@kernel.org
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lujialin4@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 12:30=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Jul  7, 2026 Cai Xinchen <caixinchen1@huawei.com> wrote:
> >
> > Delete a blobs variable with duplicate assignment.
> >
> > Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
> > ---
> >  security/lsm_init.c | 1 -
> >  1 file changed, 1 deletion(-)
>
> Merged into lsm/dev-staging and I'll plan to move it to lsm/dev once the
> merge window closes, thanks!

This is now merged into lsm/dev, thanks again.

--=20
paul-moore.com
