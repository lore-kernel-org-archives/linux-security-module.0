Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72A1396561
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791470456; cv=none; b=isd2St0udheUfOYy09sag2GdfQylCMtGxPj1ie61a4Dgs5vx4EtHVAhO8h9GPNheG6Z5nz+q4rT9F85/vR9lLxbj4qjcVMpqoMMn9Ijll+rcseWZQhsUc/XAJsuI1GKv4V+iH3HBkbPTNsbll6XoZw7lIYMSRfrY2Fce+zt3uxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791470456; c=relaxed/simple;
	bh=+mKQh+UcfzAUfPHXbKzlMPkyITU8VvmK/WXbTr+u3Qc=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=PC3rr2/M0x/uCGRET7GGYfrs+58bqWvK8enhksL7QqfaJpd1boGXCvX4yMQajLrXnM8Psp4bl/dMvaS+o40QAe2DCLWEq9kU49OgCyMkBWAXR2j8tWhmrnD8Ttq0eXZ6hM26SaPgawzcvEmSE4Z9sJL5HeqOWBY96hXfbEsY0M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZwUoDQv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZwUoDQv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609331F000FF
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791470455;
	bh=tU0EhCwxmPZQSj+ginP3oXD/pwuMFK4dwd90PCS8MP4=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=eZwUoDQvH+EFlqvo9ZuNuh3dUv1p8Rz4OL5B4mxWHpwVbzz7lm6aG+L83R0Bfx/sP
	 R9sM37V6OkKvxbApYvAJl/sqwUclh2zY41qOSaKuWn/EkPdDcaacXNSTNAKJyyTnII
	 GezBJfdbzjmp29rk88JvDRUueQJ02Fli1Y+/wuwhX2B7LZrKAMXu9oLfb4t6jjXh+C
	 AztjTyxpfqE/T2zwodL9+AhcyFEjCHMvOBIxomB8WzS0gnTGSD9vAYCvoHWymuhMqx
	 ORhUqNpTD4prpX8B+hXOfA0oxLQiW2wyXckxX0x5UfDy6m5eQbBoXAV9hMWtG5/acL
	 sGlEKHEjARVzA==
Message-ID: <sashiko-outbox-164316@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 14/27] selftests/landlock: Make audit_message large
 enough for any exe filter
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261008142604.39107-16-gnoack3000@gmail.com>
References: <20261008142604.39107-2-gnoack3000@gmail.com>
 <20261008142604.39107-16-gnoack3000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 14:40:54 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests/landlock: OOB read in regexec due to missing null term=
inator
--

commit fcf4b6b95bf6821e426c4d029e2300800d7024cd
Author: G=C3=BCnther Noack <gnoack3000@gmail.com>

selftests/landlock: Make audit_message large enough for any exe filter

This commit increases the size of the data array in struct audit_message to
accommodate a full audit_rule_data structure and a PATH_MAX string. It also
adds a bounds check in audit_filter_exe() to return -E2BIG if the request
size exceeds the new message buffer size.

> diff --git a/tools/testing/selftests/landlock/audit.h b/tools/testing/sel=
ftests/landlock/audit.h
> --- a/tools/testing/selftests/landlock/audit.h
> +++ b/tools/testing/selftests/landlock/audit.h
> @@ -41,7 +41,11 @@ struct audit_message {
>  		struct audit_features features;
>  		struct audit_rule_data rule;
>  		struct nlmsgerr err;
> -		char data[PATH_MAX + 200];
> +		/*
> +		 * Large enough for an audit_rule_data followed by a PATH_MAX
> +		 * string (see audit_filter_exe()), and for received records.
> +		 */
> +		char data[sizeof(struct audit_rule_data) + PATH_MAX];

[Severity: Medium]
Could this lead to an out-of-bounds read during a selftest run?

The buffer size was increased here, but there is no explicit space reserved
for, or assignment of, a null terminator.

If kauditd sends an audit message equal to or larger than sizeof(*msg) (for
example, if the executable path is extremely long and hex-encoded), the
recvfrom() call in audit_recv() will truncate it and read exactly that many
bytes:

tools/testing/selftests/landlock/audit.h:audit_recv() {
    ...
    err =3D recvfrom(fd, msg, sizeof(*msg), 0,
                   (struct sockaddr *)&addr, &addrlen);
    ...
}

Because the raw payload lacks a null terminator and fills the buffer entire=
ly,
msg.data will not be null-terminated. Later, regexec() in
audit_match_record() assumes msg.data is a valid C string:

tools/testing/selftests/landlock/audit.h:audit_match_record() {
    ...
    ret =3D regexec(&regex, msg.data, ARRAY_SIZE(matches), matches, 0);
    ...
}

Since regexec() expects a null-terminated string, passing the completely
filled buffer could result in an out-of-bounds read on the stack,
potentially crashing the test. Should we ensure the received payload is
null-terminated, or perhaps reserve an extra byte for it in the buffer?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008142604.3910=
7-2-gnoack3000@gmail.com?part=3D14
