Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6AC1FFC5E
	for <linux-security-module@vger.kernel.org>; Wed, 23 Apr 2025 21:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745443437; cv=none; b=FW1nVMo9fMVMx61W+v63O7Bbcy7PtawH+retXZ3vi9aXHHKWnzr3ZH3Xc1W63G3nyytSFgoNWvnwwjdlK4QfN+Z5H+D07FTLiw6JiTAJc37M4N2fZB+UydhBU4XmnEOMxdDbvGbmLkzWQxw0wSU2v0WMt4CCExabAF9YAksvJwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745443437; c=relaxed/simple;
	bh=j68s0BqHqfQMhfQdnFcDlIulnyHNA6voNvT4hSq9XIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EhubIee9bC9TK08eDneXAWfZAalV0s5634tOnVoaajdeFw9LRvnoi78kkPUIYeVZq2NSMTSFoTk/vs72368lc8lniZSt+Qypn9C81EtikRMiBlFrtBW7oqOFCyr9YISFLVD/OoysE4p1+9iwWH1C5qUYIHv+WLeZdm7HCong/l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BdVu/d48; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BdVu/d48"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e53a91756e5so271823276.1
        for <linux-security-module@vger.kernel.org>; Wed, 23 Apr 2025 14:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1745443434; x=1746048234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mb4NHCSVvmkdZLxza7aTUlyAvx0ukX1L+Ka8Awp7BkQ=;
        b=BdVu/d481IjENhE8562qKDfUHBZpy/WQWbXhm2hsS8w27q2iVrgVfxpz+zimYDmQby
         R1InPwmzhFA3JQMjpbDpkmOTuy4whpFhy9J/OYqBOOAzkcxCoU6Y+1ax2XOIL5bQKrnH
         shKTEHnErO0gUx29bzUekrQ6zCglg7ulTncKJFsEdnqKDd6oGVkZLrRIFCmu3AWLfoQf
         emDsImvsCczRgn1tnsaF1Vxgj2tNllXWo3eZyMvGWGSxCqZorADJ08cyV4UZrLhKd0wy
         PCNeOd0iwxGUMsn6mK7COGdVvJJTzzyxAX2kVjIA56Bsw7Fxqr3EL/8WwFvUTHaUhZaF
         6QQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745443434; x=1746048234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mb4NHCSVvmkdZLxza7aTUlyAvx0ukX1L+Ka8Awp7BkQ=;
        b=MdQU5NUQndXnSNodTMc7BCISObfc1jWetJOYl3ju8ChC1vWwPZti3mvb2jfUwbHVII
         5vYG+TQRxmHqyLADjJvH+0KPhaOk0zvn5qvLQvL/a2VG8x2rpJXmVqRDUh348/NEy/Bw
         n1xCI9V5r+v0esc/X/H+kHIgQ8uuy0USHnpI6zcDxnouZ4RSQI570Qfjm+uhZmPHa34Y
         6MbYO3NQPMPO2ojP8lgJh/s7WXgulQ+Uet93kxlj91eV+DCNW2BIQjyqb/9VKQCFFbrN
         Y+Oc1ZBCRdsUtI0BD7OwR9/ChV8/1vriH0/89gq6jwAneTHu+n4tkwUugIYSWiIn1ZEh
         5daA==
X-Forwarded-Encrypted: i=1; AJvYcCVSPj072FbkERIsM04q3L3KkTLRCSP+ofcesQl4vPRkyyurGuKpdR7OSaqGOQbuUrXBvDJAr25k0ZyeqBnggBr4iO5qSoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBu8tFATDUUaBSIw0hq3HUSiZ1gkZLMQRxDQGSx32o7W/bczfB
	cNDPjPf+gtPWeE/BuyDXdsGEkNZumaqX+DMwxlG8UYW4ujy/yihNN/HS6wFM8uJEBxUfrkyXXJx
	q7iTx0Pc29HxJdaL0paXMgd/vmdNKr8Lf/xZq
X-Gm-Gg: ASbGncvWGaxd9BHhCTCgGNhf6y8c2aruh0dS7JqmJVHC8L2gAo68MsjuHAt/go41B0A
	lOFmHdYKYcqmVp1CU78S7n8oXj43qba2bb6VLwPMgl+Qne2oGradwB+sHflwS3zBkpo5PnwK4q7
	GR9grjpLUfSR4z8uDFG7dTTg==
X-Google-Smtp-Source: AGHT+IHD1kvpatchYxwvexNkCpoFGQKa38HTYci3MfO2fZxpph3zet/su09KoKAjFic00mXXNtjgXiEzjHmJrAWHfc8=
X-Received: by 2002:a05:6902:268a:b0:e65:8252:58d0 with SMTP id
 3f1490d57ef6-e7303511847mr582473276.6.1745443434172; Wed, 23 Apr 2025
 14:23:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422184407.3257964-1-song@kernel.org> <973cedc0d38496b2096992bf68c72e67@paul-moore.com>
 <3897DD89-5B9F-4257-B273-A4DDEDACD56B@fb.com> <CAHC9VhShOxu4Q9yV3tkST3P9SoiL3j3ET_O4_cPAV1ES5usd-A@mail.gmail.com>
 <60CAF154-DADA-4C46-ADE8-403318EFDDAD@fb.com> <CAHC9VhRQzEGvMxyZY5Ke+GFYHr9OOF=-cTVqsK14=cfGJwy1bQ@mail.gmail.com>
 <8F162586-EB42-4CFA-B97E-314AF2FDB830@fb.com>
In-Reply-To: <8F162586-EB42-4CFA-B97E-314AF2FDB830@fb.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 23 Apr 2025 17:23:43 -0400
X-Gm-Features: ATxdqUHW1i43wa1AQU56Um-5036Sd2tzEV8wwXzSdD6TwQNiE9tEVLbpuscZA8A
Message-ID: <CAHC9VhTAQMU-HA1rFbtKVRY1=RaVwyxof3i4dtAPMvOg8u4uWw@mail.gmail.com>
Subject: Re: [PATCH] lsm: make SECURITY_PATH always enabled
To: Song Liu <songliubraving@meta.com>
Cc: Song Liu <song@kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, 
	"jmorris@namei.org" <jmorris@namei.org>, "serge@hallyn.com" <serge@hallyn.com>, Kernel Team <kernel-team@meta.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 4:54=E2=80=AFPM Song Liu <songliubraving@meta.com> =
wrote:
> > On Apr 23, 2025, at 7:58=E2=80=AFAM, Paul Moore <paul@paul-moore.com> w=
rote:
>
> [...]
>
> >>> Without putting much thought into what would fall under
> >>> CONFIG_SECURITY_INODE, I think it would be interesting to see what
> >>> hooks one might be able to make conditional on such a Kconfig knob.
> >>> Using security_inode_permission() as a simple test, it looks like onl=
y
> >>> SELinux and Smack provide implementations, spot checks on a few other
> >>> security_*inode*() hooks shows similar, or even more limited, results=
.
> >>>
> >>> You would need to spend some time to determine what LSM hooks are use=
d
> >>> by which LSMs and adjust their Kconfigs appropriately for the new
> >>> CONFIG_SECURITY_INODE knob, but if you do that then I think that woul=
d
> >>> be okay.
> >>
> >> Well, I was hoping to simplify the CONFIGs by removing one. So I am
> >> not sure whether adding a new CONFIG is the right thing to do.
> >
> > Ah, in that case I suspect you're going to be disappointed as I'm
> > fairly confident we don't want to consolidate the inode and path based
> > hooks under one Kconfig knob at this point in time.  If anything, I
> > think there may be some value in adding an inode Kconfig as described
> > above, which I realize isn't your original goal, but still ... :)
>
> I am thinking whether it is possible to have each LSM selects required
> hooks, and only enable those at compile time. OTOH, my primary focus is
> BPF LSM, so these optimizations matter little for my use cases.

Ignoring for a moment just how awkward it would be to have a Kconfig
value for each LSM, it is important to remember that LSMs are still
selectable at system boot (assuming they have been built into the
kernel), so there will always be the potential for "empty" LSM hooks
on any given system boot.

Like I said before, I'm open to someone exploring the addition of new
LSM Kconfig knobs to provide greater granularity about which hooks are
enabled at build time, however, these new knobs will both need to make
sense from a logical grouping perspective as well as have a meaningful
impact on the enabled hooks across the current in-tree LSMs.

--=20
paul-moore.com
