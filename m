Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795128624;
	b=oDSCZV3+/tdJI8AUBZnpF1Sz0lTD3S9QEChPGPlu0ByskoDZwSagGM/p8YDpwRXDgHO5
	 4wrLmRKjWw77cvRZchAhPEDn8IlQ/gFjvaebkAyKQvpDGS9YjlPk1GXB0TajILukCKg4G
	 0I0jszA3zJ8qcr1zfyy6UTpDaxTuxlAL3b9LQwe+ctO8GJJWZCzllR35StCJfX6WcjIAL
	 OqdHBkr6jTiNKZYasJQST526PlWssWp1o/JId5I5FXonfdXU7MlDo4wC2SSyi/p2bZ8cy
	 ZFQEJqO2Vm2OW6b8piz/V2bY46P1RqrwQ2fHIepFzvadGKq1WN1+kSbK8qm+7K9hyFg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795128624;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=e5/dl7hyTqZEbaIFwuAjfKmRpl1SUl3FSpNrpJ9d20Q=;
	b=ksk7Qdy+9jxvhkMbmrS0Ch/yyW5yhYmxj4EbCUOKVoMHrTutqctSDnux2iM6ycFFYdjq
	 fcsTTEC+D5WiVG3Bw17l0mnRVByN0/dDCC6vgOhO94cqS63l/pP+zk1E9E7QlWKTlrNYu
	 /hm22yZgyLHnmmBkwh8tQQ0wK7o6RGXWSyJ6wdLxqmPU/MYD9dbMGJEeR1avqGSjQXHTz
	 FaV2R7gILEoYxJoSNfAFIFWTZqSQl8VVo7Srpq4gIq5S+XbwAG9VN/Xo5MAwpjzcL4kT6
	 sH+XrGQG5Ab/TMcu+7eVR1Yw9ZPsH0EEOgckHApn2qM+4HepGtTC3Z20le3NpOc3fag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=amacapital.net;
	spf=pass smtp.mailfrom=amacapital.net;
	dkim=pass header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=CnCiCFWV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.180
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE810606A32A
	for <linux-security-module@vger.kernel.org>; Thu, 19 Nov 2026 22:50:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE810606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=CnCiCFWV
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3ad0102edd4so1819031fa.1
        for <linux-security-module@vger.kernel.org>; Thu, 19 Nov 2026 14:50:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795128622; cv=none;
        d=google.com; s=arc-20260327;
        b=L5lixq0Yk/9EpNd4GKx7EeH4ABiaQ3ThfbeUEuKTz7hBb9WXCQbW2mxZBMkBeYdrCF
         L0aCqWak8KqaRsc7lvw5Ax+EvESAqDIWaACaxOsow/hxeV1CxIlldPn+VDRoJWRoMeVq
         CRB45ktpXlRPfH18c3xV3AedVT4CgZpHTJUsPeKiRoBI33dhiFOIOKwDbEey5FKD79mO
         EEcEU1uPzY0Uf9bNWZ/1Y7qMplW/ntUPbh6iS18MXvoZUCYDFu6u2LhpE7eM66MVjn8T
         /CV3cYBV5BUaw3kgs2mT5uQiXcjAJTtS9CvfhjaVzwD/BwSS6W31TQza8KnR3ZeFLZmk
         QEQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e5/dl7hyTqZEbaIFwuAjfKmRpl1SUl3FSpNrpJ9d20Q=;
        fh=CFiYzysxBcomPmRkjYMNUSv9eEjcbduhGBF8yO5CLAY=;
        b=qW20jNyY0y17eIL0M+Kr4C+T76nujM3F7bIraiFU5bqrte8z5vg6GZVtpMRXaop85H
         Ebe5NZz8e3nqUGrXGfHdH67drW8gkdGBwG1FIdSMxeOW+7oTZHcxv0kHRz4TCQP3uk7P
         S1ODPBHrGnnkIeeuOKjOWnoGDE2EQvR4jRNYr5fc6sS7ahtnmeI/sQXYopjS4FJKy66a
         66vGYsRBp0XZ4dXm5B9XsZKOIhqrBpjlnr6w2uFRMbfMwKdAqssIdDyeW7rPyVCs+L1S
         xlkQodjWyTxrzORwK14nu82purt7/hyq7wZZ+nurGehDHAL5le8vmgsr29ArV+z+9MBS
         ophQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20260707.gappssmtp.com; s=20260707; t=1795128622; x=1795733422; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e5/dl7hyTqZEbaIFwuAjfKmRpl1SUl3FSpNrpJ9d20Q=;
        b=CnCiCFWVdqrTol4CcpbrSlDlLA3fYAIDBwcdFh6d/8N9Al+d37Kz1pAOOAx90UY2GH
         RwYwOhoV6CXoXSA7CUTRwKZNDbbugHPiviw1ZrlJjOT9eUFGc0CH+hNOe4LM76Uo99WI
         P6DX/zlh2h7WDUsD45YZT8C+yOypQZE14pxWvAPwxvGPdkR0rsUQVWvZNIkOeDQqf1cS
         H/e2Yf2FTuVfpTJ9Pqe8/BMESdOeaRtqVNs8ZsQxV9qkxEPSGBEQoNPDU9l00ioRVU1Q
         yxzIE0LYkdOSEIRca+sVlkRgMIY4FpacTm8jEYXcDJ3wMRhmrd7u6crYQQV5v980MITl
         EpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795128622; x=1795733422;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e5/dl7hyTqZEbaIFwuAjfKmRpl1SUl3FSpNrpJ9d20Q=;
        b=fZWsDU/3NdHdQEXgHJytUkjxgg2P29LJTzf1O6wBVkLivXQiWGp3qMu5juSrLWUJi2
         wPztZNk2DcCmjZinF1u4XsSFwgAPNGELTRlIkPXw2INTCbcQ2E+jV3Xy6zPELyvWIA73
         8orr+Wz/SYGu29KnQ58acWWvP+IWTWtAtsVpAsjcif423iGV81qprBBttsDhOvsRFBH+
         deb8+LapDSDf7xQS86MYmfyQ6GgCk2L6WoZLJfyJ0LL+AG62bFLd7BaEOTcV0N22Ut/B
         dw+HZXo5++HH7ph5C+7/xuAW65AowWokxZhNJJi7AdHgv2wZwST0K37CgTMcyqcTfle+
         RaQw==
X-Forwarded-Encrypted: i=1; AL+hErFfgYgytV8FTmj+XVOWBCrDObSsMD/wFTGZNs1ItJSXdMIBam9jopUhIHSvADBhcRCe69eLn9C4sz1XlEGj5UTHNBEIBXs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ICSJKm/TVForSytdUXcPHuIJyKzDv9cgahZjSANVCL+vFMCPg
	mNgrgZparf3JhSf4+9dX/S85ZgzbCjk5W+OFH3l1Ixzlo/qWnJkppXLsc+RIB9cvSOADsqlT/zu
	dHNm4bP4/Nx58lzoG+Z9n0ivYux/PV0nslxvHhxoq
X-Gm-Gg: AYBFou1l95x62rv8qtYDTqFP4PmtL4apm3FIak07TJthvmNxkOLyWhKIE7mQAxk+unr
	4z+xCYi7s7tA0fhuJx8AVG0OhpS7Cqg9UW4Na+fRYcnNnzMwWQoJvemgusaSJNIvrgNek0zyc+J
	maPFZrPWs6TXnIaY2HtuoptX/vQz9NYfCQcdLBYDDIyG+kegVgfaSOGNx+TddTn5apBXxZl0n8d
	tKA47ComFmrws4OncfZ0lJdg6Zja7fBky+cPbXj+NZF524nKZ8h9TJPL/Q65S1Fon2EGZnfHeBo
	ZQCnETjHfcS1rzI3yvuIPVWNNeodsXPhyhl+aAEcFdbPI0sP020VIEkLhBqO8ZTHaDlSLPjPbvC
	Bhf8VNQTUoGsWqoNvAqt+SEJlS4FVeoyCqA==
X-Received: by 2002:a05:6512:3e13:b0:5c1:4793:bf31 with SMTP id
 2adb3069b0e04-5c1bc8495damr319148e87.58.1795128621989; Thu, 19 Nov 2026
 14:50:21 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117231352.3816603-1-jarkko@kernel.org> <CALCETrVUkbpoFjwSAejyA4b_9qEauAP_36i=O8Op1ifp8aUkqA@mail.gmail.com>
 <av3akYFOYaeQZauZ@kernel.org> <av3bkDnwmjunTleX@kernel.org>
 <CALCETrXPLeUgxyhjP4XuWS46FKB0TUHF5PcMkdMf+qeEXbyXRA@mail.gmail.com> <9463a969d35a7d5ec5a56aeb67644b94.josef@toxicpanda.com>
In-Reply-To: <9463a969d35a7d5ec5a56aeb67644b94.josef@toxicpanda.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 19 Nov 2026 14:50:09 -0800
X-Gm-Features: Aa3M54r1P8ngsOHB8Vhj7FvubBRj99w4Go1f1fZhV4inbefIYqqcV1gzmh9n2Fw
Message-ID: <CALCETrXt-Do28BHDpbrA98kEy-tQuorxD8c2XsW24Tt8Vspdtg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/13] Namespace for namespace roots
To: Josef Bacik <josef@toxicpanda.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, 
	Serge Hallyn <sergeh@kernel.org>, Kees Cook <kees@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 9:30=E2=80=AFAM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> On Wed, Nov 18, 2026 at 9:46 AM Andy Lutomirski <luto@amacapital.net> wro=
te:
> > cells: The dance where I create an anonymous mountns, mount stuff into
> > it, and then attach it to the cell is cute.  But I think the userns
> > interaction is wrong: you are making me assemble all the mounts in
> > *my* userns and then clone the entire tree into a fresh, non-anonymous
> > mountns bound to the current userns.  And that clone operation is not
> > free and serves no actual practical purpose.
>
> The copy buys us nothing, agreed.  That's just what the mount API gives
> me to work with today, it's not something cells wants.  If I could make
> an empty mount namespace and fill it by fd I'd use that, the "root" slot
> takes a mount namespace fd already.  Extending the API for that makes
> sense to me on its own.
>
> The mount namespace staying with the builder's userns is on purpose
> though, that's what keeps the cell from mounting anything no matter what
> capabilities it was given.  The builder sets the tree up and hands it
> over, so the cell only ever has what it was given, and the mount code
> isn't something it can attack from the inside.

I don't get it.

Using the builder's user namespace means that the contained processes
can't be ns_capable on mntns->userns.  But this solves very few
problems unless you also deny the contained processes the ability to
unshare userns and make a new mountns, and if you can do that, surely
you can also deny the ability to modify the mount namespace.

As just one example, a mount namespace could have a little flag to say
that it's *in* one userns but its owner is a different userns.

>
> > cells: I find it *incredibly annoying* that one generally cannot put
> > new mounts into an existing container using most existing container
> > managers.  I hit this on a surprisingly regular basis.  You seem to be
> > baking this into the whole cells design.  Why?
>
> By design.  Allowing changes to a running container is what causes the
> problems.  If you need another mount, tear it down and build it again.

What problems?

I get that allowing a running container to modify *its own* mount tree
(or any other mount tree) is a meaningful attack surface.

But the whole ongoing discussion about cap_userns gives a clean way to
deny an entire container the ability to modify mounts (although we may
need to augment it to control mounts if that's a specific concern,
since CAP_SYS_ADMIN is a bit overloaded to say the least).  And surely
cells can find a clean way to lock down the container.

--Andy


--=20
Andy Lutomirski
AMA Capital Management, LLC
