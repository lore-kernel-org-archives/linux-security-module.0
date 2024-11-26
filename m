Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BAF1D88BF
	for <linux-security-module@vger.kernel.org>; Tue, 26 Nov 2024 15:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732636646; cv=none; b=bdhXJymDnsW2ioEI6Hbai0ozquHOrZfgAqb6xVQPRAhS+QERUWNVdi2VuYjnH6+UDOHS+6vQ1XDoLQS2MGCeGpsbKrmdB+m1V+tC/VABzAaSv5gYPfMvRcb8F8o3BLiHbC96F+SB3DyWr+Hyy2QfMMxywbVtL78JUb09c7WYQwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732636646; c=relaxed/simple;
	bh=M097b3AoLZGGrSY88ozNfK3DDyUr21f4JQcRdhc8+mo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OgOxxKAIBN9mfByTVEEJf4MF/M9jq7kqxzLksMQfEU4z4yBOQhvwcqPixLBTVVN2voTVpopQ6i3yjqPXvI5O729rglJ9leIxDckWTKLVABYTOm9NfgPaXZD7lJTesZ4IocmK4UBXvgBG7vZdtI1tKnqVrjojlTTVXv71pJ2zbm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Cp94FTsi; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Cp94FTsi"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6ef1921383bso19732577b3.3
        for <linux-security-module@vger.kernel.org>; Tue, 26 Nov 2024 07:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1732636644; x=1733241444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/E2x/9m0Jw9OhM2T6isfKESQbjzMtZ3n4WMxBZ5NYAg=;
        b=Cp94FTsim9ffSsyWFkgl4I2LIo/KS58tDE8pg0Rt1OvNfh24lznrGicfforS3MeSVD
         u3TfTLLYeuCQDnRy5KcZq+tnbfaPRhVe6hVQ7kazvqe4SAYfYjjLt16dm9hDYqorWz+X
         zkQa2zdtun4LptE2Ie5TKcSqw7qZhfTuTW2VhsQuTAQ9qfgIVdlVAXQ4hmAL3O1zJ+2C
         yV2RSFAV5voKxGC9TISsHPoeJIeIswPBDFJoyi48upIn1z4JYeYNF2KRRWlOTmzYzKWu
         McANHwqdt4vxMgqM5nhmSTTs0inDA5ryQiDtP4v+FEvdWGfXUgwLb37Mhrnqs7+VBqP2
         6LMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732636644; x=1733241444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/E2x/9m0Jw9OhM2T6isfKESQbjzMtZ3n4WMxBZ5NYAg=;
        b=esDjukjpvlnbVrol+gXAHzD1Unpk5qtcNUPnAGJi3wkTO0eP7Zn0x80/809Y3SUtPF
         tpjdCbbNxnGh1qPFNijWPxH/jCLZW69BN0euX5StV26MPLbqw/t5sGAis69OuNhDsLri
         c2kIZl8AXQdaPWDM/ARbY1NfGBxoV/BpW3o6vZk0cV3IbjoiXRycDMgRMzG1PXrAa8r9
         dZ8ZDJ9Cd+nyh/JUMkizgLfFcKtfW4orm6wfZ0LgUHtz89fccJyG9uCOQ8clpvmeMQSj
         cgOn+liORFb9V5PZ55dM/p2l0ZWt7D6C4ScXAgK2MPG9QZBss/OcYbps646FtGxR7Frc
         6ZCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXu1WRqxv+7EpK5IwZ9t2fAEU39x04eDVIBFUWIhPJ1g8lBFPMnbA2lxBnVWRkkzjPGKWvNwnyKjkWApYohZd0KQYTgKn4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3PKSaAG3q4A2bJ0dxp8GVGowk0UfF6prOcbD6c/Qfqli59j8Z
	a1fsEt+T+HhX3ZTUWEjj4pBw2eYDyM8scCNdfCOrKDEqf07tYRV8p2rRuOejLONL4w3vA3AwpqY
	g0Ck+EcL+gkXwcN+JyXr5nqbjGe24b3KaA2C4
X-Gm-Gg: ASbGnctNxmiIZKj/EEesQg03MrNp4qj42Ip9yPfRQywg01sRXHflmARoSmq3pKr3DXK
	l6iZDVXCpgOrJ8Nw8vQRaodgtiT5+oA==
X-Google-Smtp-Source: AGHT+IF1Clm0YywkLQZI0a+CkqXFyBhHuwmyMfxWR8/y9KxVZw2fTN6BtGj26+4Z3na+aij2uacRKZKketxnwJax8Uc=
X-Received: by 2002:a05:690c:6301:b0:6e3:153a:ff62 with SMTP id
 00721157ae682-6eee08bc182mr175416367b3.23.1732636644270; Tue, 26 Nov 2024
 07:57:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJ2a_DeUX9UdAYOo9OwG-yXSH1etKQZortPcyxfzG70K3N+g7g@mail.gmail.com>
 <92e5fd64-8c75-4e82-981a-846364fc7a38@schaufler-ca.com> <91a227f3b57374a8aece5480f285c433d3888572.camel@huaweicloud.com>
In-Reply-To: <91a227f3b57374a8aece5480f285c433d3888572.camel@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 26 Nov 2024 10:57:13 -0500
Message-ID: <CAHC9VhS7KRcpA7cHcwpKknYsC7iZiBjZGVz1xznC=d=uDYu7EQ@mail.gmail.com>
Subject: Re: ima: property parameter unused in ima_match_rules()
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Mimi Zohar <zohar@linux.ibm.com>
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	linux-integrity@vger.kernel.org, 
	"M: Roberto Sassu" <roberto.sassu@huawei.com>, "M: Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>, 
	"R: Eric Snowberg" <eric.snowberg@oracle.com>, LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 2:50=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> On Mon, 2024-11-25 at 10:23 -0800, Casey Schaufler wrote:
> > On 11/25/2024 3:38 AM, Christian G=C3=B6ttsche wrote:
> > > Hi,
> > >
> > > I noticed that the `prop` parameter of `ima_match_rules()` is
> > > currently unused (due to shadowing).
> > > Is that by design or a mishap of the recent rework?
> > >
> > > Related commits:
> > >
> > > 37f670a ("lsm: use lsm_prop in security_current_getsecid")
> > > 870b7fd ("lsm: use lsm_prop in security_audit_rule_match")
> > > 07f9d2c ("lsm: use lsm_prop in security_inode_getsecid")
> >
> > The shadowing was inadvertent. The use of lsm_prop data is
> > corrected by this patch.
>
> Thanks Casey. Yes, this is what I had in mind.

Looks good to me too.  Casey can you resend the patch with the proper
sign-off, commit description, etc.?  Roberto, can we convert your
comment above into an ACK?

Lastly, Mimi and Roberto, would you like me to take this fix up to
Linus via the LSM tree, or would you prefer to take it via IMA?
Either way is fine with me as long as we get it fixed :)

--=20
paul-moore.com
