Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACA251C07D;
	Fri, 18 Sep 2026 19:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789758029; cv=none; b=BFbuOYBGV6UVhbJ2MsdEdJg/IXWslJlI/PRBXjd2GSb4Jyec8ytawsPxLAF3B9Vz9e7ctBA8Y57vclKXJyrRj+DLsvS3QlzmxYD7k2P0Qh9YSKaLFfkjfbEY9e05d+nk+iaP6+aNCpd9ORlTui9BXSEEoEZwZCgkhJqJ4hC9FK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789758029; c=relaxed/simple;
	bh=+tWpDvGpNi4+jmypfZitUksv7Kka5HPwlv5DcdqY2ek=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gGmrMm3Iw7ggUljkPN7XLUtIE3PTMydqacuZFPqVKE/susU2vfOMAZ5F5HhoobDMauXNKesNwJYPWwDGirquWEBc2IlYdZRimga5x8r/azAcJjxfWF6DfCUnXVHRMOiIWPI0Fy3p0j5eHJtb56m7mLpiSaiMbujZCVEJ13Cy6x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoPAeMU2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoPAeMU2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AEDD1F000FF;
	Fri, 18 Sep 2026 19:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789758016;
	bh=+tWpDvGpNi4+jmypfZitUksv7Kka5HPwlv5DcdqY2ek=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MoPAeMU2RVs8pK0gI7UED+Ccvr3PqvWFm+j8vme+biM5MOSrMeZGToTYfr5E6RFLR
	 HNn3t66YsH6vpoe7TMKGS1Eqpk/WnvYiHTWKrlkrgdJpoVxiFQPyGalVux7AU70+Oc
	 lT0imhKv3RwKg6IDB+njEyCD7jWsoKbSYrZtfRYOghz7WJ4BGOllBGM1xIKRf+XVyk
	 Khsb7vkgRGXIL/UtgJr0bkXGhIoLdZ+tOu4ds+iQOSk0en9haRP43oTfcUz0dWI5b/
	 i4OTpPH1dZ+3QpgIKdzr/yhGA7A2z7pLVyLzYuICGv5Tkz2vXG69iPQ3CHkiRar6Ta
	 0CdJnvT9v7DGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/9] landlock: Fix rule tracepoint context
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20260918185036.608651-4-mic@digikod.net>
References: <20260918185036.608651-1-mic@digikod.net>
 <20260918185036.608651-4-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 19:00:15 +0000
Message-Id: <20260918190016.2AEDD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Name each event after the identity it reports. Add-rule events describe
> UAPI rule insertion, so rename them after LANDLOCK_RULE_PATH_BENEATH and
> LANDLOCK_RULE_NET_PORT. Check-rule events describe matches in internal
> rule trees, so rename them after LANDLOCK_KEY_INODE and
> LANDLOCK_KEY_NET_PORT. This remains accurate if multiple UAPI rule types
> share one lookup and stored rule. Keep denial event names based on
> filesystem and network families because they describe final access
> decisions.
>=20
> Use u64 for growable access masks passed by value to add-rule and
> check-rule typed BTF callbacks. CO-RE can relocate pointer-reached
> fields, but it cannot widen a scalar callback slot declared by a BPF
> program. Keep native access_mask_t for internal state and trace records.
>=20
> For add-rule callbacks, report the normalized per-call contribution
> passed to landlock_insert_rule() and expose the complete validated flags
> value. Put the ruleset and flags first as a common invocation prefix.
> This distinguishes duplicate and effective-zero additions without
> recovering arguments from saved syscall registers.
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Fixes: 63747c94774d ("landlock: Add landlock_add_rule_fs and landlock_add=
_rule_net tracepoints")
> Fixes: 3f1f106e4c14 ("landlock: Add tracepoints for rule checking")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918185036.6086=
51-1-mic@digikod.net?part=3D3

