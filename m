Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8090576C75
	for <linux-security-module@vger.kernel.org>; Thu,  8 Feb 2024 14:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707401823; cv=none; b=sA+nS2a5zO2BL81f8aCG8xtZssW35lHmKo0BE65S2ZDZorenvXNxts4Ap52Bjz2+0IZDM/kzoCI4QNFqJP9LeHruQsJ/+7TwXDrvy/MLijtcsDkSIOl17EEsqDcciSrgt0WWAs8nQCx09Sb9/E+VSxPvGxRDlw6RQFXjC/q2fEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707401823; c=relaxed/simple;
	bh=ujj/RLFDfuqS7PIZP68+3l/KZkd1KHttxlgRuGySCOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RPyEUhMrnMaU/PzhU6zxxx2CCRt2xYdUTnvXfjcCbhcqhO6iYdofknFotR/olgs0rPKQl/5vUSW9ONOtcwudoqfKPaj1w6TPRRo4So+HlVSPWc3whXcUleGSUD2M4tlKS5oYqWY3hEad0O5xdsxWaAAHJ67n/JzgoTy7YppfdFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cpIHrnvw; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cpIHrnvw"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6043d9726adso7521127b3.0
        for <linux-security-module@vger.kernel.org>; Thu, 08 Feb 2024 06:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707401819; x=1708006619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rHe4xV1s4X4NVlAmyq1Fqck0kWWWvVIv4qB+Ky5Oo4=;
        b=cpIHrnvwduqrSfAbUDvwcTPVwb8rM5uk1zLq3xwzi1+jkLLXKNesv/zHRV50VOFZaB
         mjlVz2xq0Xc8wRbbScpCr3Wh5pqRY9CZuD3kTn2yTGmzl+o8rE0z/xm05jjVGkOWGawM
         Xxxv8E2Gc9w3bLvEcWitgQLLWHaZUaDvduZSg9GuLo7L3cKhJ5uJxf6emmisiriIiips
         pdVU8EKnp07svFd9da5oSFwwvxUFKN4N4Lb4ISOGhVuRuy+FWj1WfqwXv6Nb3t+CYuAw
         QNYIU7wJoFpclTxaQAF4DVT9S3X15ml/BEDGJMv/ATW8HrjwHnYfPjXqKrRyICCe0GOf
         InRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707401819; x=1708006619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5rHe4xV1s4X4NVlAmyq1Fqck0kWWWvVIv4qB+Ky5Oo4=;
        b=quY/eFe2+hxZFvTzFb027ISvuaa3G6/t9zHl313rDfFP9Mi5m+BR6J38894uE+us7Z
         Md2JmObJNk3h0g8HN3HzbzjR3D8XPa9S/3iP6+HzOr2dM2mXda4jh8suWZlkOqLjxRIZ
         78yeDXYfi1j/wHU7iy9it8qzGBjiq7qf4xHuEGAUkPl5zucjniSEAWNX2BTxu9eQHxIl
         IZ2EkRrPuXI6LPmrblF2C09OomI0yXPsvrjW7GUc/evNiMrAJeh9Y5V0ro/X2+O+sVCT
         rQ3VHIjKNF8B9A85Bf+2t+Z22kFrwKULwSRWlyw0Dkzm5IZMqdEA/5AwAsWUfRItbuyS
         j6Vg==
X-Forwarded-Encrypted: i=1; AJvYcCU6ko2y5hd0JinJ9phSVPsr/T2rmGtNjzZtRsXyeduCbgWLn1IihXIs0zZdtguXUHXNderPZ6QKI99yImzJbdC04YnOTilkfEQe8eIVHZteCHejonzP
X-Gm-Message-State: AOJu0Yz+9UXrSWf7s42aylpXUR+0/1ShDgavb543yeSUNGnrqDzneU9Z
	+oY/zPvT0uFeplie1NF8A3pq1R8MNDboFus6PWuNzutaLor7dpq20BfdAwY6d43WOE1KAzAFS8r
	i6zXpXHK++OvtDsGmlJ1sRCJ0sV9qW1k49N7Z
X-Google-Smtp-Source: AGHT+IF4KdKYv/i3KNL4LQkNiYFcff3UiechbnntE/n8lsxGtDCyAecpPgauuzlLRFB/79dZx13Kgoa30gmOFF58owY=
X-Received: by 2002:a25:7483:0:b0:dc6:c2ec:ff4c with SMTP id
 p125-20020a257483000000b00dc6c2ecff4cmr1925355ybc.6.1707401819151; Thu, 08
 Feb 2024 06:16:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
 <d54ca249c3071522218c7ba7b4984bab@paul-moore.com> <dd8a979df500489c0d8595f9a3f89c801ce6f1c2.camel@huaweicloud.com>
In-Reply-To: <dd8a979df500489c0d8595f9a3f89c801ce6f1c2.camel@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 8 Feb 2024 09:16:48 -0500
Message-ID: <CAHC9VhRu-_v19zWS0Pm0-4E-PWONcfR1-=Ekz9ObuOAgL0Y+sA@mail.gmail.com>
Subject: Re: [PATCH v9 0/25] security: Move IMA and EVM to the LSM infrastructure
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, chuck.lever@oracle.com, 
	jlayton@kernel.org, neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, 
	tom@talpey.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, dhowells@redhat.com, 
	jarkko@kernel.org, stephen.smalley.work@gmail.com, eparis@parisplace.org, 
	casey@schaufler-ca.com, shuah@kernel.org, mic@digikod.net, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 3:06=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On Wed, 2024-02-07 at 22:18 -0500, Paul Moore wrote:

...

> > I had some pretty minor comments but I think the only thing I saw that
> > I think needs a change/addition is a comment in the Makefile regarding
> > the IMA/EVM ordering; take a look and let me know what you think.
>
> Oh, I remember well, it is there but difficult to spot...
>
> --- a/security/integrity/Makefile
> +++ b/security/integrity/Makefile
> @@ -18,5 +18,6 @@ integrity-$(CONFIG_LOAD_IPL_KEYS) +=3D platform_certs/l=
oad_ipl_s390.o
>  integrity-$(CONFIG_LOAD_PPC_KEYS) +=3D platform_certs/efi_parser.o \
>                                       platform_certs/load_powerpc.o \
>                                       platform_certs/keyring_handler.o
> +# The relative order of the 'ima' and 'evm' LSMs depends on the order be=
low.
>  obj-$(CONFIG_IMA)                      +=3D ima/
>  obj-$(CONFIG_EVM)                      +=3D evm/

Great, thanks for that.  Not sure how I missed that ... ?

> > Once you add a Makefile commane and we sort out the IMA/EVM approval
> > process I think we're good to get this into linux-next.  A while back
> > Mimi and I had a chat offline and if I recall everything correctly she
> > preferred that I take this patchset via the LSM tree.  I don't have a
> > problem with that, and to be honest I would probably prefer
> > that too, but I wanted to check with everyone that is still the case.
> > Just in case, I've added my ACKs/reviews to this patchset in case this
> > needs to be merged via the integrity tree.
>
> Ok, given that there is the comment in the Makefile, the last thing to
> do from your side is to remove the vague comment in the file_release
> patch.
>
> Other than that, I think Mimi wanted to give a last look. If that is
> ok, then the patches should be ready for your repo and linux-next.

If Mimi is okay with the patchset as-is, and both of you would prefer
this to in via the LSM tree, don't worry about the file_release
comment, I'll just remove that when merging.

--=20
paul-moore.com
