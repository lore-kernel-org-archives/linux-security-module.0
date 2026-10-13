Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2F151EDF4
	for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 16:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791910659; cv=none; b=NGcdFBTgjTne5OSeCMmi9GFPgsIpP17TUpb45hByjIO5tT6YuHfGgt6AXwQwPb4YXy4/H5mvAg76trTYTwIXR84gz5e8EcvpfQMyt2DSZA6y/Fn5wcUWwgzcl+3j31298xQuP4S+GG76qe6e75GFow5JF+4L9SF1D+W9iVArYjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791910659; c=relaxed/simple;
	bh=GY9rtKssj7QBguurmvinCVqEqEwuOKbv+IBEw9HX32c=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=H+WtI1H7dTQ5FXieAOA3aRR2BTvYvqmuVI8RoVQqQ8U508fZD7/wDgajPHnGPFWoE9le9GAb7wr863OQYwZ6xEpe45VplnjPSkiDorGHok/0yOm6hQsfKNdIrvEry2OnkRODb+9JnkXae+wvK6FRS2ZdRpOiFa1arFwXwkjwKeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZyYup2SD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZyYup2SD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D736F1F000FF
	for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 16:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791910658;
	bh=GY9rtKssj7QBguurmvinCVqEqEwuOKbv+IBEw9HX32c=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=ZyYup2SD+10+FfWaRbVVxw1R8N9RtfkYFaFQVzO/3PCG1NFXODWSbQ12dgdpCtfFp
	 Mxx3djWgiIBNl1iJFaxnHua2DcoqcPEJQWlRP4w47NyqW1NHEe0e+UKMrMwCsvZk/q
	 6Z0/wvCqQlYfrdmIcSVsL/wk0fFGhCdLjlcWOHMeyZRZA3z/2DGQ+YdE2vHETskLQo
	 yUv3OtpyX3TAeqtmV+UDM8IFW7fYrcsz+teswhzozYXvcHw1rue8J1h+eVZ5mKkalY
	 T/yC8SP2ESbBJoS+rz4i6lNTWEzXbFnSSgXmAiR9kFn5rZAIUPC/dK9t42PzMlZMVk
	 2AwUPE5gaqKnw==
Message-ID: <sashiko-outbox-170177@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 11/11] selftests/bpf: exercise the lockless
 path ancestor iterator
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261013164800.2906577-12-utilityemal77@gmail.com>
References: <20261013164800.2906577-1-utilityemal77@gmail.com>
 <20261013164800.2906577-12-utilityemal77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 16:57:37 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Walk the same ancestry four ways and require the position counts to
> agree: lockless from a non-sleepable program, where the RCU critical
> section is implicit; lockless under an explicit bpf_rcu_read_lock();
> referenced; and the hybrid that walks lockless to the second position,
> hands it over to a referenced iteration, and resumes there - the
> escalated position therefore being walked twice, once per mode.
>=20
> The sleepable work the escalation exists for (d_path on the escalated
> position) runs on the resumed iteration's first position, after
> bpf_rcu_read_unlock(), which is the only place a sleepable kfunc can
> run at all.
>=20
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013164800.2906=
577-1-utilityemal77@gmail.com?part=3D11

