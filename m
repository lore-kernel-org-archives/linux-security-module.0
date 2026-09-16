Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CAD4D6C31
	for <linux-security-module@vger.kernel.org>; Wed, 16 Sep 2026 15:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573384; cv=none; b=GqzVjnaEZgT6H1dDECnPswrlgp9/4CZbdLZ2zEWj91mjdcIvkLOEnC2UKXA2VIqf4DJdr9tw5rHduqcPxPs24YuVQ7Ao23XkLye2n2duw/Iaw3q+FHaI2Z8GJks6kaYz/seA4SRbjxxLOuQj1JrQ+GxoLyRaEijdRGVkOF5iJSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573384; c=relaxed/simple;
	bh=xzkEs5LiSja3dbzzicR21Qn0XTrKAUdE1PB/NwOkDos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tDsNPkzTRRqeFNNxCAJqtrYR8UVGPOWI2N3uNLLOnzhyafbi94UG2ZlDXISjrpm3VDng1o/xLWWSJzT23HGkowgwTJtLeOBGlJ0oaiPFHRylenAY7EHm7wUJoJpEqC9fPM6heBj0Z1dVbAO45Xk/YuApMMjZnsJJxARs36G4LQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kod5TDBu; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kod5TDBu"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd38e0e5dso12198725e9.2
        for <linux-security-module@vger.kernel.org>; Wed, 16 Sep 2026 08:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789573380; x=1790178180; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6Sim/Uq2bss990wMC5LOqQrIp+Z1Yp2vLh2aHVXHuME=;
        b=Kod5TDBumB6ymIwo7H/RjtjtrnCuDomtfuR8A8HGXpN9zgO1n4IyBkl3igGXu+7HOs
         zw27PQMKllXoPTSLu/HpagKlvd8CU2+NFGHJiZ2WyfdcqLz31yTLCw7AVgVcp/IYfVbS
         I1Xlt7B7YltXwZ+O7fBbgLEprxlZ4BCPNCxrn3IRJudknDVfer8wPbaz5xom4wVVpNSL
         LHRQSL7U4jIQQm+VrlVv4qjOU1i3lYzkhhb76vIkfawkePesgPYnJBAcsLVs2B0IHc7o
         eavU318LnTyYFVlk/KW38KOB3d93So/91Lwn4vbIy35Ivb0es/onxLKICAcyvHkNdNk/
         IIlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789573380; x=1790178180;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6Sim/Uq2bss990wMC5LOqQrIp+Z1Yp2vLh2aHVXHuME=;
        b=Ll4hjkBA8cd1ahIJucssMlVmD+3SmGN9XHL/wXRy4x2x7fTdsDK1XYdnsMjngNWidt
         e+AH25n+WD86uAOZurobiqH9AFaJgA2iRGwdKDe8E3FmV6oOzmbCRzFmbEpbLo8SIlVO
         RrDTlEMIkQOU/OpS0y9wjFc+Q0KUR3/bXfcHDJhHBdeosIh/sMf9af7hjFOd4CaIIpiO
         Vbe/PUyePO70Aid2JnC9sb04LD36CG1luKzvcuwxLX0+WhiudOjrlEKZ3TmObkqfw93d
         ZY7s+Zj+AFlsxYFgn/0/N5tc3QMj/48M1WisydXlQRmdtn4HZ19M443lxmCY5OH8xRUq
         OTaA==
X-Forwarded-Encrypted: i=1; AKwUvBw4gDpKv6IMhTpUMa6ie/hhmrHEwP9CWl5Dg8VI3QJ4R2f8XlX005tcjCKlmVjwuSQC7/lexcmIwkxM7oG6WGcDKbbgDqs=@vger.kernel.org
X-Gm-Message-State: AFuF++lgb9cVWX5zg8hEi3xR1p0Md8vaD3KQLiYiXyaoOpdYABR64eg/
	orn9V7Hobp7BXdet7EJP1WQ89+M8qT98y/g0Ii7o6waf6O5azQeuaoCXXU7y8LmMWQ==
X-Gm-Gg: AYBFou2BwlJ1oPNhRbJLygUY64FPdERckvSUdukIa22WHgLJR0h8WByAd1r/pAzkuDa
	PwIqSZVYSyce3v/j5QCmxrhDuTunG0vtIkappisp0Q3Ac4p/Li/3vict9vnwGyoCCf3eTdjMoum
	FtD1M1LSgKdTzMxaYtnFziH6PLUbEco/S4xE/qwLaEQylGzgyurI47xhs+Syl0vCeBjOj7D5LjL
	l1uxTYBoLLzNi37qEQptJqmLE7G6IvaW4/FEgtGENdQHkSye9gEjDKUyzDWSC1kREN5H3+mafdB
	CbjgvawLTM1R4BZtSF7zm+fkqMqQSbPtPbl+UGVjxqCveXcVBysxAZTK1ESTAvDewqITH3mUn76
	DycPtLOqT96UhlcFEMz1xPsIZZFZVlyUjAHQUSiBqIrmlqk3vaLEntqSR8djGzQv8O8ZIxpsPFV
	danNYRKGI8Ec8/BRCMPbsUQ9pVXwclmhW9AluGnQqiH+ss3QzXHHgBfjH3dg0mEY10HY0fu1dbm
	ORW+VelwDAB6i0CpfCGo8V6Necv5MBXRdHd0SM=
X-Received: by 2002:a05:600c:5489:b0:49c:cee0:e7c1 with SMTP id 5b1f17b1804b1-49eb7340a28mr62591055e9.16.1789573378755;
        Wed, 16 Sep 2026 08:42:58 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:a430:d4f:f001:4a5d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf27198sm7580265f8f.15.2026.09.16.08.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 08:42:58 -0700 (PDT)
Date: Wed, 16 Sep 2026 17:42:53 +0200
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: Christopher Lusk <clusk@northecho.dev>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: landlock: clarify TTY signal scoping
Message-ID: <aqq4_Xh_JJ6OHpST@google.com>
References: <20260914.b8a029f9abb8@gnoack.org>
 <20260914180946.1462099-1-clusk@northecho.dev>
 <aqqJAZfG9FC7PgMW@google.com>
 <20260916145255.1587381-1-clusk@northecho.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260916145255.1587381-1-clusk@northecho.dev>

On Wed, Sep 16, 2026 at 10:52:55AM -0400, Christopher Lusk wrote:
> Hello Günther,
> 
> Thank you for the careful review.
> 
> The phrase "or otherwise driving a terminal" was LLM over-generalization,
> not a separate mechanism.  I checked the paths I had in mind against the
> source, and none justifies that broader wording.  I am dropping it.

Thanks for double checking the wording, sounds good.

        
> You are also right about the verbosity.  The generated text expanded a
> two-line distinction into 15 lines and obscured the main point.  I will use
> your suggested sentence and remove the signal enumeration.  I do not have a
> stable kernel documentation URL for that list, so I will not add a citation.
> 
> v2 will contain your sentence and a short LANDLOCK_SCOPE_SIGNAL remark in
> landlock.h, matched to the recent MAKE_REG whiteout remark.  I will post it
> as a new top-level patch with a Link back to this discussion.
> 
> I will keep the positive selftest you suggested as a separate follow-up so
> the documentation clarification can be reviewed independently.

Sounds good as well.

—Günther
