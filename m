Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795200278;
	b=3fYpvXOzUlOI6k1vwM9tZOW072RIUezoUr8bWRmu5makTwmCYy1KXE9vZLH+Beu26C00
	 Xb2ZUDfz0dUiaZApkt1wol7/VkbDQQprdIEQgI2zFXQI97lv1DRTYg60nLT3dn32Nm9Hy
	 O1mHJOcwdTVYOrb1bgkqCVPvj/bX3wyHJOXfZDEgYjHI4MA0e/uMVau3FUtHjI+u9Fx7a
	 e2i4gtRvzTx8oqgo5vZBzjFjYpyF453vuiS47Tz1OV+Z5lzUoq2Otk7GrRsF56gM5fdOQ
	 Flgg5WtIoQT0OvqoDe+X/fIFjcFXzJRcMNL3ZCg1+OhWF5S1NtSFIFVLY5/buq2frdw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795200278;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Ge3pmyLmXCv4hB1zhJ0eXKU1oHUklR6Msezg+VICCTM=;
	b=tBF8WWxfr53QaswiVVDwDtxDHAe1JbspVkoIbCSNIsQMJv7K17lpIV+dDsaouuSIiC18
	 Heq5Dl0vP8DEsBDSOXz3ctirIbI++xwA+oYrEscUaoApIvHoMa3RHh3v828neytxAz5Y5
	 Y+h4QdWKb1nIRXaOJXv7+YQXS3gFV2tzZGdrIx8Zm5r7Q8y9yUecSJurIXJVMo1DYQSB1
	 mYS94CJErW/+qBINKCTisxgSu3m21jx0vKzUgLSdCwxScFUNAi00F3wVC6v8K7EPSnjNW
	 9Yf4ukQ9+fc0hjCHG4mEKV9B/XCa3Ku5o0dCBJk9lQnvxCs9a+fkV5JOTvLgILTob8Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ZJr5zkin;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.171
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A14B60A2616
	for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 18:44:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A14B60A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ZJr5zkin
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5edf97136aaso734707e0c.2
        for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 10:44:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795200274; cv=none;
        d=google.com; s=arc-20260327;
        b=Z+rsxbrnH9wRs15MqP70fERCD/lZsuW4YVNAd3+3sHVhRwiUZ6bsBuBoTYVhLJ5cm0
         frcUThGqKneRUX+jC9sfVTCQD3HgJAKSt3+LeZCnWSdNRHeOTKW4xUoJ2toY2Q3sQcY8
         xeH6hfKWi1ReYjDGJj7nt7LUGiXeHfDuvP0inGJcwy3WOQIHnZgv2vKTqEGVSkETUPNi
         2n+kwvJAjxMSwrltsAA9RTdJX8JxrpYIHnNCMqTP3kW6TR6uubRfv7o6Ol2WMGIPFJHd
         py0M2iBmB1igSwd/vzWQ4d4cskyql+f0zshfEtoKg+TnsVVkSge4SUqZq48jZ1KnVPE+
         zGTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ge3pmyLmXCv4hB1zhJ0eXKU1oHUklR6Msezg+VICCTM=;
        fh=fWFVBDXGhP3GNx4gLtMkV5bLra0dPgcM5QgtL7PLTrs=;
        b=qAcr6rva2Nl3xydDQZ2u0wiD9pG/tsKddNCw/xUtDtvARBwCSRPJT9/s9kofcn39eb
         GbAwhc4cCS862P/tfX2kDgbQzNthVZggy/4cFOGbtE9rETwSqDDgg95m8nVqxF1NssM2
         KAs0TlEncA8cVHb8oUkA8hA+V/Ltcw+nVmlkVOlc9TpL1FvbWBESOgeobkvTQGX22Bjr
         HXnWyOzdEzPPPKUuCSmlYhqR/e8kQs2aARJx5tMKjbOAUf6skdtx68s3xchT627H6MKq
         5AvB/Xyy+s32wlhXNm57wTK7K4eqHpbLc4W33tpMK6EDlDhfebAO63xTTAAR3MFtgrWm
         Dpbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795200274; x=1795805074; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ge3pmyLmXCv4hB1zhJ0eXKU1oHUklR6Msezg+VICCTM=;
        b=ZJr5zkinlPUjzP75ruooLP7bnWorZ6KrEMUYaB2+nsH98WYaKEFKXiR9A5uKaBjlf2
         a9k/J7Q8TeJU6JcxrwI04dMyEynnO7TSBGo7Qo4bfuE9VqxcaHZDV6dOjmqBndWcT5Du
         9BDlJjShUnHIguuNKB4eF4mQRXny/A4cdZZfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795200274; x=1795805074;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ge3pmyLmXCv4hB1zhJ0eXKU1oHUklR6Msezg+VICCTM=;
        b=2ffZYUpJw6uyAToptt7eLiw5+nibMbcw6F0fp8XUTClU5UuJRijio+nHd7ayeZDAk1
         8TUpECcB09Z3EqkiB0laXSCYXfGyYGgry63BOqcUeOj43omSo/KTf76n0II0xFijOIEv
         Fe//TeuEqOra9B2GCCpu6yEF9hJk0dQHMPfAkftZDIFNmgPCd2OyzYn97YvIxq/Xpbhl
         /0TTSC41SIrgfjuy6txiknTPHLvOtPb1adYmOG7/LY/kjggrXte3AaB43C+MqWCcOs+e
         8UrxbkI08OZe82oR++C8qdhA1igy9cc2NcJQXQjUHgMJO7yql5BR+tMGmrbZovmpxrE2
         L/mA==
X-Forwarded-Encrypted: i=1; AL+hErE7wd5+/yBpkHPVCHNugE71aGbL8A1hxaU4YNAaKI5zhogHmPJbf2ljoSxJuEJnk/KqoyIndp827niwpqTeEKkbuBa9A08=@vger.kernel.org
X-Gm-Message-State: APuU4Z//FVgFnOx5kPex6QwW1ZkNAca7DK9aJyq2Ffe3u9FeCcu2hsQw
	hjAsBnevgdgSSwarFDVR7QUqxg2cJw31hDTV6zDeFJ+vreFSKO8/aDq35FCC7k3kIRe6fuVpOtv
	SjoKAWsn5PLduVaxDvBcKCREHqu66GO/BwKOkLA2S
X-Gm-Gg: AZFdTZcVuDE8kpTV8zyQlNbaMS3BbU6DKppZS4vjDuCsyZ1HBSB0tC2vEpD8XVyB6xp
	t/Vqjr1zpY82woT87Wp5XsgRBQEmFbXcB+7YYI66tCHRe7Toug+ba5bEwbHXiyUFuviFIhqTbwJ
	9HPX8GQ0R0RlDKlyDeLQg9pCfd8JzmA7V3gOR4LLTi8NBNFcXYBI/G6PY6vktICHB3SKbyJhlPH
	HdPbogYLEBWPU4YbsoKusiVH47Pj4FOxp4dTVL/yoieSQPnVeTQYateeg1Zuas7jB2nizeusYZS
	n0xO5woWfczOjT91qPHLQj6cFzDabna+H9gB4siGgGIe5jp5bywtlpa0YfM9qgWUbvpT5dcpeWc
	OZJRLZXJ/JkN0B4Va9LYPHQdq5vdI0/eBwXVvoVasEqfSKpAQEmZJzg1bDJbufRiNsloUdw==
X-Received: by 2002:a05:6122:30d3:b0:5ec:3e18:a188 with SMTP id
 71dfb90a1353d-5ee8adf1536mr2653900e0c.1.1795200274471; Fri, 20 Nov 2026
 10:44:34 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1791023194.git.tjdqudcks0424@naver.com> <d7e10b50556ab3b79c7132018249f6f7c608411b.1791023194.git.tjdqudcks0424@naver.com>
 <asLNxHYQ/xQ6KaWy@hallyn.com> <CAHC9VhRMCfahvx89HjSoHfyKR27swLdt2HZuM1enmoi_gxRyRg@mail.gmail.com>
In-Reply-To: <CAHC9VhRMCfahvx89HjSoHfyKR27swLdt2HZuM1enmoi_gxRyRg@mail.gmail.com>
From: Micah Morton <mortonm@chromium.org>
Date: Fri, 20 Nov 2026 10:44:23 -0800
X-Gm-Features: Aa3M54rASSxX4QbVhBp00t0f3m1HpQ0YSwFJsYfciMSYXLIVp5sGFTUKS5zqr18
Message-ID: <CAJ-EccMjtVkvM5bZzUKDAPcOAKZbd1Lc59oNrW0U8m=s+4R9eg@mail.gmail.com>
Subject: Re: [PATCH 1/2] security: safesetid: use real GID for GID policy lookup
To: Paul Moore <paul@paul-moore.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, tjdqudcks0424@naver.com, 
	linux-security-module@vger.kernel.org, James Morris <jmorris@namei.org>, 
	Thomas Cedeno <thomascedeno@google.com>, Shuah Khan <shuah@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 4:26=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Sun, Oct 4, 2026 at 6:05=E2=80=AFPM Serge E. Hallyn <serge@hallyn.com>=
 wrote:
> > On Sat, Oct 03, 2026 at 07:34:15PM +0900, tjdqudcks0424@naver.com wrote=
:
> > > From: Sung Byeongchan <tjdqudcks0424@naver.com>
> > >
> > > SafeSetID policies constrain the ID transitions available to a task f=
or
> > > each source ID.  id_permitted_for_cred() always builds that source ke=
y
> > > from the old real UID, even when it is checking a GID transition.  If=
 the
> > > real UID and real GID differ, the policy attached to the real GID is
> > > therefore missed and the lookup can return the unconstrained default.
> > >
> > > On current mainline, a test task with real UID 1000, real GID 2000 an=
d
> > > only CAP_SETGID obtained non-allowlisted GID 2002 despite a 2000:2001=
 GID
> > > policy.  The bypass reproduced for setgid(), setegid(), setregid(),
> > > setresgid(), setfsgid() and setgroups() across three clean QEMU boots=
,
> > > and enabled access to a synthetic group-protected resource.  This sho=
ws
> > > a SafeSetID GID policy bypass and group privilege expansion; it does =
not
> > > show direct UID 0 elevation or a universal local privilege escalation=
.
> > >
> > > Build the source key from the old real UID for UID policy checks and =
the
> > > old real GID for GID policy checks.  In three fixed-kernel boots, all
> > > tested non-allowlisted transitions were blocked while the allowed tar=
get,
> > > existing-ID, no-policy and UID-policy controls, and the existing Safe=
SetID
> > > selftest continued to pass.
> > >
> > > Fixes: 5294bac97e12 ("LSM: SafeSetID: Add GID security policy handlin=
g")
> > > Cc: stable@vger.kernel.org
> > > Assisted-by: OpenAI Codex
> > > Signed-off-by: Sung Byeongchan <tjdqudcks0424@naver.com>
> >
> > Seems obviously correct.  Thanks for the find and the fix.
> >
> > Reviewed-by: Serge Hallyn <serge@hallyn.com>
>
> Looks good to me too, thanks!
>
> Reviewed-by: Paul Moore <paul@paul-moore.com>
>
> Micah, assuming this looks good to you, are you planning to pick this
> up?  If you would like me to take this via the LSM tree, please let me
> know.

Hi guys,

Sorry for the delay! Yes this patch looks good to me -- thanks for
catching this, Sung!

It's been a really long time since I sent any pull requests to Linus,
so it might be a good idea for this to come from the LSM tree if you
are up for it, Paul.

Let me know, if you think its better for me to dust off my old GitHub
repo and pull request etiquette I'm fine to do so as well :)

Thanks,
Micah

>
> --
> paul-moore.com
