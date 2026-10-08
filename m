Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211863932FC
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791470075; cv=none; b=OmLboV6a94ncF0/C4Ggg8bB8C3SGAVPZII0oskbi0/Yjr737URusFihoPqHJIv8rVC5rZZIR9o7uH1g0lVxlqP8dBL0gIP59GgRx9oV2RPa/gGuDYmUU6TMGUx55RUXAPHRdeXc5uzturR47BvQRe2ljXY4bYUGgu5Yo7ebaed8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791470075; c=relaxed/simple;
	bh=HdvjduLcu2749YwsxGo8F1zWonn7++vVjvC/hGNDCjg=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=tEwT3lRsDaioc86cUnjKS7IpbYJ8kTQkBNJ/MN5ewdo5r529kZtG5aTEN2N8kgd/AbkaoGi0ZN6WlOue6UP97qFZYUt2kVBpv3XGuNXaw9L4Juxvm+zTuH/A7LXpmHbP8I55K5O1+l3P9e4vdiAjyrj2VVP//OYbXjSNMEHc6AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhhODplp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhhODplp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9D61F000FF
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791470073;
	bh=0EAjS6ZEAB1oy3z2/sHcnRLOg8ZAGqcbPx5XnVQVTGA=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=QhhODplpJjzrWYa2Y7q8QeHr9DAGuLlRp8p63q4kX2VnCShj7G1fTjTg+c/VpqVRz
	 SYP3uuGEhVz1502RQll8cHNptE+M9nefZsQjPvA1QSVErQYOzfMgCm8MoeIqH1g8ml
	 nejTLcZWI1vfH877YB3gV2vW5npjAj4j5w8HXquJ4hYrasSOCmqA36nFkDm4VSHGzQ
	 ZWbEuD21inLnhXmNWG1CTAJd/K0+WjcJ+bi4DtmeLV9I+QtuQAWhvrJA+9/ULEYxAB
	 aT+94Qk2H7p+L2BTtH90mKdWw8rqpJ4A4fGlzp0onI9nqwOMoPXwQcDL2DDQx+7H5L
	 IaLk2ZY+kEHzQ==
Message-ID: <sashiko-outbox-164300@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 20/27] selftests/landlock: Fix the snprintf() error
 check in matches_log_fs_extra()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261008142604.39107-22-gnoack3000@gmail.com>
References: <20261008142604.39107-2-gnoack3000@gmail.com>
 <20261008142604.39107-22-gnoack3000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 14:34:33 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> By storing the snprintf result in a size_t, the chunk_len < 0 check
> could never be true.  Store it in an int instead, matching the return
> type of snprintf().
>=20
> Fixes: 316d06b01130 ("selftests/landlock: Add audit tests for filesystem")
> Assisted-by: LLM
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008142604.3910=
7-2-gnoack3000@gmail.com?part=3D20

