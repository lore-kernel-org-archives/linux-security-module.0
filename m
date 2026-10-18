Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82183876A0
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792344862; cv=none; b=q4hR/O2eLCjDzv/SfRD5C3g+ZBoCfZM1bNix2Zz+WpruC6cfLv7Q8OAmIF4oQftVpjESUTYMJFbOJRFPQzW4DkA92o6/aI5XZzY4gTu3ynlI5rEw+x6XcdSwCxS466V/GlJzq+AiI1COgmbGs3oOLV3FEInHPbS2GjZS4Ui7Ivc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792344862; c=relaxed/simple;
	bh=zGY1tvo/q1STgMADUWjPJ5Ml7ftbcB7Z9jDvoNlpmIw=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=CoMbidHzXfmK0pKcqwPV95M7uYgXEmCzaTzcQh31dZjXS8dqD0rrD+nK3W2V3g/sL4rtZsimfbnhnKDn47I54R7+jCV8JJYMqo83Kjtg8eKpzpr8QRLFYWqQSgrmVIN7WLMo8umDHybd5RltiWCkF0f4wjlHBu0/1aemxeut+0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPcPRFXe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPcPRFXe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 655611F000C4
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792344861;
	bh=zGY1tvo/q1STgMADUWjPJ5Ml7ftbcB7Z9jDvoNlpmIw=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=fPcPRFXeERH1S4bKZI95bAsssRS+LG+7UoIlK0XoS+ifwxOaiP5qASyerK+uhb7VI
	 x3UU0mfL/5XtF6uFPRqpyog7rUnK57M0Y5oru+eoLLhT8I8aYWlYGxlrRmXgtB790m
	 olnDH0oWTduSIF6WD6vb59pynSGLo6mwOovOJz4qfGhLXzJjv8IAxILPX+QVEQKJVT
	 wGeBTjqQyB+SRSiAMdSDMkEL7ikww2mXUO5EeSKnaf9ZRfVpNKDlOuK3HEKSRV2KlD
	 t5/05PzOCODS/AJ95+UAvlODI1pmECj7gg/N0IalWG8Tz5NeLpKTUL7XF5uHyXVowd
	 5C8tNOkrsP67g==
Message-ID: <sashiko-outbox-176323@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/13] cred: add KUnit tests for the id rules
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261018-b4-cred-ids-v1-2-7bdf2db4ea9f@toxicpanda.com>
References: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
 <20261018-b4-cred-ids-v1-2-7bdf2db4ea9f@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 17:34:21 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Hold each of the new functions against the expression it is about to
> replace, word for word as it stands where it is used, for every
> combination of a few ids, 0 among them: 729 combinations of three uids
> each for subject and object, and 4096 of the twelve ids that
> cred_ids_allow_control() can look at.
>=20
> That the conversions which follow change nothing then does not have to be
> taken on trust.
>=20
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018-b4-cred-id=
s-v1-0-7bdf2db4ea9f@toxicpanda.com?part=3D2

