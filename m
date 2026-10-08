Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BC238550E
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791470200; cv=none; b=IX0Z3XFLn8saysuJe+2Lq82VZjgJtnA1l/QDs+SpNu6f3Sa7NrfAyG6VdTFJYtza1xW4Oh86oVSyraECrxHg1wPmZaeRMIwBGVnW9i7idNUKxTcw0yOnwd4R+zKeJheNWZtvfjK7NOLjy7lzR1XsPSy5VKCF8YG3ugEekmJmV8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791470200; c=relaxed/simple;
	bh=RYsfhB/ZkeH+UnYbqProiziXeAUOuhGyZiKj+lnVIYE=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Qxz0RUBTsJZ2Vzf9kNoZv3I94K8gjwGahB7WRyvDDlGLZSd1bRIU48nXx9bSYNnyb7Ds4r4L5kiXTYEQ77goYiFWmDj48koqABu3j28SqhVXeY8lrTOf3L7BSb3aui2Zt+Z4b4Btrn96rQByqHQIRMcCXZQX+2gujGhDf3ze/OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=de40JKer; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="de40JKer"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E055D1F000FF
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791470199;
	bh=oqmcYR13XkBaEqauNaYwjSSlFgQxg2o+f73SCIMeYpE=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=de40JKer55YabASBYkWAlawxP5i4QGKGxxB2NgqZmVjaE1wkPgYW8L6WG9Nm7uBGI
	 h+UOOK9l6eyZPhP50UEDoEyyqg2cs8dw30E4jY301saEKw8N2GJNRWCDlX8aPQ/5cu
	 0p5fKizQF+P+iH77GXt7dHui+NZOCzG4AcQ5UWZYfTqTda/yA+lzcFA1AVxRRBNlbK
	 KGPgt+3m/LoSnNKe1phwYaEHQUbtO1nzlg0zjEz++CEfLPplNE6UP/ZCSe3ARropKl
	 ph81g1T+EyCB/PRIt9xV6gpOHJ+90Qpjb7x1QfPTm9rnZ08FSrQM/Kk9TGJ89A8zUf
	 NpueRyzGP+I8g==
Message-ID: <sashiko-outbox-164308@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 18/27] selftests/landlock: Fix regex_escape() error
 handling in matches_log_fs_extra()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261008142604.39107-20-gnoack3000@gmail.com>
References: <20261008142604.39107-2-gnoack3000@gmail.com>
 <20261008142604.39107-20-gnoack3000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 14:36:37 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests: errno clobbering by free() in matches_log_fs_extra()
--

commit fde0a2f164054d717ba379b4c41a67fff69162e2
Author: G=C3=BCnther Noack <gnoack3000@gmail.com>
Date:   Thu Oct 8 14:25:47 2026 +0000

selftests/landlock: Fix regex_escape() error handling in matches_log_fs_ext=
ra()

This commit updates regex_escape() to use a more conventional error handling
interface. It now returns a ssize_t containing either the number of bytes in
the output, or -1 with errno set on failure, and updates the call site
accordingly.

> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/s=
elftests/landlock/fs_test.c
> index b1ce0f810e10d..9abc2adef79db 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c

[ ... ]

> @@ -7471,13 +7472,14 @@ static int matches_log_fs_extra(struct __test_met=
adata *const _metadata,
> =20
>  	log_match_remaining -=3D chunk_len;
>  	log_match_cursor +=3D chunk_len;
> -	log_match_cursor =3D regex_escape(absolute_path, log_match_cursor,
> -					log_match_remaining);
> +	escaped_len =3D regex_escape(absolute_path, log_match_cursor,
> +				   log_match_remaining);
>  	free(absolute_path);
> -	if (log_match_cursor < 0)
> -		return (long long)log_match_cursor;
> +	if (escaped_len < 0)
> +		return -errno;

[Severity: Medium]
Could this free() call clobber errno before it is returned?

If regex_escape() fails due to an insufficient buffer, it returns -1 and
sets errno to ENOMEM. The code in matches_log_fs_extra() then unconditional=
ly
calls free(absolute_path) before checking escaped_len and reading errno.

Since libc's free() is not strictly guaranteed to preserve errno, and may
clobber it during internal operations like unmap, the original ENOMEM could
be lost. This might cause the function to return an incorrect error code or=
 0
(success) instead of -ENOMEM, masking the test failure.

Would it be safer to cache errno into a local variable before calling free(=
),
or move the free() call after the error check?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008142604.3910=
7-2-gnoack3000@gmail.com?part=3D18
