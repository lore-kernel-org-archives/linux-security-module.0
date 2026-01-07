Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A109E7E0FF
	for <linux-security-module@vger.kernel.org>; Wed,  7 Jan 2026 12:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767788351; cv=none; b=utDqZRXcGG2onhd5UoK/EllSztmC5mysevNT82fFltuWDPHhKfxFGZu4aVUXNCiXNLUwgaZUzKaRKkeEZKx31ySwXR6N4myekHf/3oycsasESUA9g9tOrIFs4MLLp98ykZ6Rkals8RvA0+hYz3IMtc7yMVyZYa6BPjHNuAM9Dkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767788351; c=relaxed/simple;
	bh=Du1ZH7UaR/LMIzEhhXRVSDZFGDmHszdKorhWkmTIupE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=NDvj2/0rZMI5ynDoO5SGuyg9vPCjobb3CN+lt/o8hjk9wO6owTmr/12qtC6+g7ni90cnA91bDzyLdEnv9JDE16KfBEN8tON7zXErYfp0pYJ6+SLqKF5CMToMaSBPshaHQGfuckqMC6CjlpGd3XHCk7tV/JU7WVVq0nJ+JJWdmVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7PA7H9O; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7PA7H9O"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-78fc84772abso22761677b3.1
        for <linux-security-module@vger.kernel.org>; Wed, 07 Jan 2026 04:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767788348; x=1768393148; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NyhL8h00txQCvL7xwCkIxa3s6JoM3Y6MGsihZCm6qto=;
        b=P7PA7H9OT00S3/0tOoGVCx2djmnBYEHnMumr3r4HQ4QY27pV/PWvdWewbLAdFu5t7U
         z9jEr2NZy4vNFtnGceZlQQtgf5gVkh2qzqf0FI+ALTcXXjCUD/CWm3KMxGW1USZ6vMKo
         mGufX/JmQNCBAANua1xOXQ+XzaDm2mDktLZtcEw8BdOPEUukCuo2S6ZfBHUBaql2zAso
         Uocmr0wL/I5G3SFGxlv8ZevejnCZ31XlxL7OVOzAlDDPGl/kKa4OarJCGISYwfIu4EVC
         56d5sFx1LxlAjQLOOuxZO40VUhkzHzbHz54jyH19L+EjiqO8lIboXSebBdWyDyXxkp1k
         ui7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767788348; x=1768393148;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NyhL8h00txQCvL7xwCkIxa3s6JoM3Y6MGsihZCm6qto=;
        b=txtSUFM6aAUZL/8taKbvqnyBzoXs4uPSyl4sA0+PGdxsgr8aBTOPWrHKcSESg6lZeF
         g8hfuWJC5hPm9JfQLKx4xVXDuiSupLDYdViyzxV0fHQnxtUpOxOq7wFv+zPFyFGnp0yc
         Qegcyo15L7xxvjjtOKdBJ4unWM0ojXvuvXNmugJeIW0pIhW+M5R5P59eVGqgmE3ZcCUQ
         QQovT8g8w9SYinXyZ8HtIx0uvPArMvFqrVkiri+m2RZHqv97JXzyO/Sai+3d3Eg8ebRT
         klNCFyroKJeUZ0ByisR1Xgph2m9KSMuuChVDfC/uQMjCk/GJc80ZuG9Cere8kcLsvCfm
         EudA==
X-Forwarded-Encrypted: i=1; AJvYcCXzPJMwI/OKzx8bTxPr+VxoGPdPB1wuD97mkuMid+y4BXJ3XF/cFfadxyOVECACMyRlaHrBVAMIm3/+tmp7JztCQ0UAPvE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx90f9WCoOO3Fsv5sDlbRWhHFae16RS3ut2KmwdB5awnbYXAZXM
	5Yw0nN0Znda4HntjCKuK467AU7n0DM0vFmO2zorQuwsc2zfcdLBIuVs2
X-Gm-Gg: AY/fxX6JxQVEstxr+rCyj6Zr2PzsAF+yvgESVZMKtVkAWh44QCzuogSzlbWNrV4RcIz
	krY11DwUsMVBE/nCI2i2gTTBwyH1CH73+ZUbtH4B1DiWiuws0XrzSNb5A1A30tQ9p2gymRCEeTS
	EvmVO4e+R+5XquWIWoWtnhv2D6zbs+38l6NkyG0kCdF0ChFRi3m4+/EM2OOKyDAwl5IysNOhH08
	MBqzFU8d/na4WbSMS1D5THWJBmmANnJ8Ng9l9t0sJ/SCOr3KeyrBCP+ENKOucLoIWEjC0cSekfo
	+Pk7G/Qgr54reoxuH0cqlIpQuv3tTqKcUyKbDQRqEJcOU2G9CtyGpMmjfHPBbW9PMIfCIjUKDSd
	E7scJ5gf9IZZIRO9t3jv3YB+lSkwkcRLJEVFO+/fM8tjfcexHegTfqXkCL+z6EaNXxtSWcVPoj5
	5Ex0nGc/Gfxua7d/AQwj3u0MitmL8a30B0wp8NZH1Fpw03PkqDPvDlbQQlXX17oGG9iB9Xfw==
X-Google-Smtp-Source: AGHT+IGe6d3wK+F2oI5smfquV943SvsOAUFT2g/G4jiF0GRSBBHckQTsqxcsCdECKZxp46AqoNV9bQ==
X-Received: by 2002:a53:d90d:0:b0:644:6575:b4f6 with SMTP id 956f58d0204a3-64716bda110mr1503288d50.33.1767788348314;
        Wed, 07 Jan 2026 04:19:08 -0800 (PST)
Received: from [10.10.10.50] (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa592cdcsm17918557b3.25.2026.01.07.04.19.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 04:19:08 -0800 (PST)
Message-ID: <2da3f1ae-1fe1-40c4-8748-9fb371e696f0@gmail.com>
Date: Wed, 7 Jan 2026 07:19:02 -0500
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Justin Suess <utilityemal77@gmail.com>
Subject: Re: [RFC PATCH 0/1] lsm: Add hook unix_path_connect
To: Kuniyuki Iwashima <kuniyu@google.com>, =?UTF-8?Q?G=C3=BCnther_Noack?=
 <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E . Hallyn" <serge@hallyn.com>, Simon Horman <horms@kernel.org>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>,
 netdev@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
References: <20251231213314.2979118-1-utilityemal77@gmail.com>
 <CAAVpQUCF3uES6j22P1TYzgKByw+E4EqpM=+OFyqtRGStGWxH+Q@mail.gmail.com>
 <aVuaqij9nXhLfAvN@google.com>
 <CAAVpQUB6gnfovRZAg_BfVKPuS868dFj7HxthbxRL-nZvcsOzCg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAAVpQUB6gnfovRZAg_BfVKPuS868dFj7HxthbxRL-nZvcsOzCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/7/26 02:33, Kuniyuki Iwashima wrote:
> +VFS maintainers
>
> On Mon, Jan 5, 2026 at 3:04 AM Günther Noack <gnoack@google.com> wrote:
>> Hello!
>>
>> On Sun, Jan 04, 2026 at 11:46:46PM -0800, Kuniyuki Iwashima wrote:
>>> On Wed, Dec 31, 2025 at 1:33 PM Justin Suess <utilityemal77@gmail.com> wrote:
>>>> Motivation
>>>> ---
>>>>
>>>> For AF_UNIX sockets bound to a filesystem path (aka named sockets), one
>>>> identifying object from a policy perspective is the path passed to
>>>> connect(2). However, this operation currently restricts LSMs that rely
>>>> on VFS-based mediation, because the pathname resolved during connect()
>>>> is not preserved in a form visible to existing hooks before connection
>>>> establishment.
>>> Why can't LSM use unix_sk(other)->path in security_unix_stream_connect()
>>> and security_unix_may_send() ?
>> Thanks for bringing it up!
>>
>> That path is set by the process that acts as the listening side for
>> the socket.  The listening and the connecting process might not live
>> in the same mount namespace, and in that case, it would not match the
>> path which is passed by the client in the struct sockaddr_un.
> Thanks for the explanation !
>
> So basically what you need is resolving unix_sk(sk)->addr.name
> by kern_path() and comparing its d_backing_inode(path.dentry)
> with d_backing_inode (unix_sk(sk)->path.dendtry).
>
> If the new hook is only used by Landlock, I'd prefer doing that on
> the existing connect() hooks.
I see. Did you have a particular hook in mind to extend?

One complication I see is whatever hook this gets added to
would also need CONFIG_SECURITY_PATH, since logically this restriction
would fall under it:

From security/Kconfig:

config SECURITY_PATH
    bool "Security hooks for pathname based access control"
    depends on SECURITY
    help
      This enables the security hooks for pathname based access control.
      If enabled, a security module can use these hooks to
      implement pathname based access controls.
      If you are unsure how to answer this question, answer N.

config SECURITY_NETWORK
    bool "Socket and Networking Security Hooks"
    depends on SECURITY
    help
      This enables the socket and networking security hooks.
      If enabled, a security module can use these hooks to
      implement socket and networking access controls.
      If you are unsure how to answer this question, answer N.

Logically, this type of access control falls under both categories, so must be
gated by both features. No existing LSM hooks are gated by both afaik, so
there is not really an existing logical place to extend an existing hook without
changing what features are required to be enabled for existing users.

I do see more uses for this hook that just landlock, bpf lsm hooks
or other non-labeling LSMs like apparmor or TOMOYO could take advantage
of this as well.

Günther did you have anything to add?

>> For more details, see
>> https://lore.kernel.org/all/20260101134102.25938-1-gnoack3000@gmail.com/
>> and
>> https://github.com/landlock-lsm/linux/issues/36#issuecomment-2950632277
>>
>> Justin: Maybe we could add that reasoning to the cover letter in the
>> next version of the patch?
>>
>> –Günther


