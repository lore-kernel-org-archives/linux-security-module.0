Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793739497;
	b=ULyp4IOvppvZXp3PBhSQ9wemwFM8062sDtS7fTR16+B/q4stKlbUWZ22E5P8zJ3a1Ogz
	 Wan7UdhjDHeYVE8T/xy5yFYYz1j7hFTE+3TvSK1napjdgDtcGH9jzQpNOrySZTrpX8oK2
	 +wlKTNxl9Esx19cDW8EAJ8edENBOC8EiRMZAuEA0y8nlBaB429zmQYT0w4JFYhC7HYB6T
	 wvpmC70+sH9BbqL6j32gyU2v66ps1eIGbvy4Q3QphC86gFQzxxuQkp5/kFCy/pVB09s4m
	 rAt4ULCTXhnJsUBjH87VyW2IAEvwxDzP58CAnXKVGYkezt5ezw8Xr8RoAN60agEDVFg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793739497;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=xlEVARhdYpI51yqwMKIfAYo+e0yxy9kuj0dDIqLQxSg=;
	b=hJwzQFFPUtZcaBzfuNgg4Di4PHlGxGT6+s2SxgXvGk8yEDOOCot/NJDlRvV9/+RZxV+d
	 f+WdOPiPEkh7yLcwbi+MXRHvYaRt66i23AKG+42MtxrzKNLnUUMO/iRJhkWKmcY2o0gmK
	 DfWd1nQuErM1v+y1r3k6KwtcvO4ukObmVfZi3CyqXWx/52onWJp669Jyk/sUEihM6VJ4C
	 m8dKL2MFAv8icX5Rj8hnJ6MpTyfc/8DIHibNEUQ0gCMqOEZG/Zht0lYiGU2WVqHXzH1nw
	 Yz4rp4SocnUELslsprU2wUQ0NJKqyV8fHbsTo4KFWWkvGaxMNyBmeTRLAR5ofr1IavA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=gNjU0kU7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55746606A328
	for <linux-security-module@vger.kernel.org>; Tue,  3 Nov 2026 20:58:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55746606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=gNjU0kU7
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e9995ce866so38186255ad.0
        for <linux-security-module@vger.kernel.org>; Tue, 03 Nov 2026 12:58:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793739492; cv=none;
        d=google.com; s=arc-20260327;
        b=Q6hnat39IvWe5XO3gR/s2v3RJkiAyoS+Yu+B6OuR05BDwMn5A0Q+RjWn/e8K3752NI
         gpBh8nt6/AthJ/LspmsF55iC2oIKrif2XbspBDAnRCVefvDI9Yvhmb7OoWKi0sVtG6MA
         eJ1ETgQvuCNeA7ttfgiKynA9vTa3TYB+wpv6Qbha0/8TmhgJTOvDQcLjvB4PnP/GXrlE
         RkFNUvNjMQDff20fQ+8wIi1ChexXr8UBQsnYEGMqPkIpaaApjA8gGiWGZXOBgRCabHNH
         0emG2vdKXUTK5JOxniDv/r8nAwfivGo6GqK6KQCycNLaXu5oS8PLiO1tZrJopkkliC5e
         xLDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xlEVARhdYpI51yqwMKIfAYo+e0yxy9kuj0dDIqLQxSg=;
        fh=nhxRp6HFF2lXqwiBqNub+i4tUo9gIiybEop+RWhdAqU=;
        b=Pgs0csCFqPVY5m+DrMoB3sIlx8a43k0XwJgJV4fH5aSUn514e1Z19h34njrAf3VwsD
         CNHyr+wOUbhj8Nfq2cTEHheDwBgno7wuzUV6EHxxssUq+Od8VMgUBxA6aoOjlfFu0q3Z
         CwQys3mNtgT2qklOBIGdA9mpVkyf3sIs2yvTWy2Yse0Z3YAu5w5a0tLqR+q4Im4N8b18
         OECc3roxlDxe8JuNMTPnR5iOgf+457xqitvZ5bAFzPRbjogL287KhI3yfzmYQKkSMQ29
         CcemLECnxjDY4WebEYw6vl0JX1zjZJ+OMMSqaT7PUcshkDKXJd7L4+g5ZDcGCSQPBU4Z
         Cj6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793739491; x=1794344291; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xlEVARhdYpI51yqwMKIfAYo+e0yxy9kuj0dDIqLQxSg=;
        b=gNjU0kU7sM8uH5XC2H7b99i0TvtIF03FfKAOB0NH5+8azPBEMvKw0LopoHo9aDtdiz
         VDyjVtVrUAN//DSQQ5olLEEOAjJMZhga8ZmFPcbKfD2Ft577yKe7V/QcHq6FX9oHF/yn
         3bCew/1NgBdXPqXDNjd/pB+bgpfklJXpLzQeRdEu1INssd8arH3ktroB3iBaNXq5+ufX
         l8KdXY9cOuOdz7Ack0IyhbVI7+narclszD/zONZH/1ebAaSxDxVSg3gNl50MRCwl0e2m
         B4k3pyP+iT+yfzugI1Wl73+2lNHj1HV2Ub4A50Y+lzMd9mZvMR/+dyBS5pq+lnHK5qZV
         pvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793739492; x=1794344292;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xlEVARhdYpI51yqwMKIfAYo+e0yxy9kuj0dDIqLQxSg=;
        b=XM5KzX/ZacINF0MoaM3OkEDLOo2chHddzEAkeG41zD2gQzcVElTPbaLN3EYyPiBuTv
         /UHMy9PZSfqU/WZr/FiGXJP8qjo0tR+F6hgn7WgLJrwXYXxJNJCrXJX7+ssxwBkkdC2B
         p0+FaZc8i5HR8fNKZr9SMtFoyo8/Zp/y1mUU/ABpC6ODZ24ZmFJGDxSGR6VKt+M85nFs
         LJHARFbRyMEY4ejJ+gZ2Tzc+sYK8s8hikK1UDV7CRq64Vj2xjiluG5gVby2GETABHcuy
         R8+wDc0YSeIuW2petHJw0aO07CM6pFcusJUoD1vIkU30MPEr6tLnwneqPiigb7u6/kpl
         jgqg==
X-Forwarded-Encrypted: i=1; AKwUvByikJe85H/cafmSTHUMMaILqG7p1sSYl4pn7EAR+95Va8/4oBwdmXwdknBtJPBkZkgqAKRBYyLqhLG/jr5xcKsnQT4zzLo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+EaNhj79TttZ4Ag0w5jzM9L22D834ohXOPFC+/pcJFlxml4dsR
	4JpFen12bEKbe9ERkQpJ6Dloego7tkOzi73zu2USinRKWtvTscpurl6GpNHwf5iVzGeR7N6WccD
	Wwrln6SbuGonEjv/BUIx0xVlP7bljv9VdtjqqWWUu
X-Gm-Gg: AYBFou1XMpQwY8JEDXB6Ni7uMue5samgWTceiwZbn9mwAi9WsZ6VGxnfbw0dyO0jNOl
	Bz3NUHhQTuzRI8X0nv5OXkKTUCLxwi0LSuLzWwNjaGKNeUQ35guxmanZVNeiI1HK+2Lio0wYb1u
	1iZpusF0BThbk69ex9eMHQyvHXMrLmzjhk3W5yADJIpgkt9zzYX3L9eJ3EQRG4sgN46CimkiltP
	WVukfzgVaO4Z1Rc8Fqx5vZduA+d+JajvbgxNV6XflWYaLDthMo4djs6gNAF68mxvXB0DB5nInE3
	R15lbqbrVLgdlCac+6erKYa3univ2i9mb9SKUTB/S8GMe1v+4suyKPYjt0PlazBwhNeXkVtAGiT
	tP2Qng0Y0Pq9SkLlv2LntyRyiTIHWlmqvWXaKZNDeEDijbaF+TMdabreb+WGoe+2ik1Lo
X-Received: by 2002:a17:902:ce81:b0:2e5:cb1f:898c with SMTP id
 d9443c01a7336-2eb364ed0f9mr139787525ad.46.1793739491564; Tue, 03 Nov 2026
 12:58:11 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019222858.1766-1-drifabdelmalekmohamedsaid@gmail.com> <CA+xk8n--qQfYro+xsGu+z7nuCrAJgwzOOyrc+iXuBeSsPOWjhw@mail.gmail.com>
In-Reply-To: <CA+xk8n--qQfYro+xsGu+z7nuCrAJgwzOOyrc+iXuBeSsPOWjhw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 3 Nov 2026 15:57:59 -0500
X-Gm-Features: AclHuK_j1m1BaQJmY5Z4xSDq4UylbUple31snnL4So3-rHmuEym2QzQD59EuRAE
Message-ID: <CAHC9VhQzeCgCx9mi6pvbQKLH=P8b-o6JuxeUo0QfyebVGPdXGQ@mail.gmail.com>
Subject: Re: [PATCH] lsm: don't call d_path() when current->fs is NULL
To: DRIF ABDELMALEK MOHAMED SAID <drifabdelmalekmohamedsaid@gmail.com>
Cc: jmorris@namei.org, serge@hallyn.com, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+975ace299d6ba2eb1cea@syzkaller.appspotmail.com, neganhat@gmail.com, 
	audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 3:18=E2=80=AFPM DRIF ABDELMALEK MOHAMED SAID
<drifabdelmalekmohamedsaid@gmail.com> wrote:
>
> Hello,
> Just following up on this patch to see if anyone has had a chance to
> review it or if any changes are needed since we're at 7.4-rc1.
> Thanks,
> Drif Abdelmalek Mohamed Said

[CC'ing the audit list]

Not yet, but it is in my queue.  Regardless, thank you for the report
and the patch!

--=20
paul-moore.com
