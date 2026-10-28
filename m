Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793195076;
	b=j9r8gyzKffLpjuz8JtckreWyz6HaTtEuXgHXuDeQn7ADzKcdYGzYInCk2SAYu3fZAU2h
	 xIPnHikJPj9uzSDe0fmkDSyX4Ie4KlPNpsGLG/6BhWuScNP23x+4lxIIISPxYwaMis2MJ
	 DpO+6YAp8Gi8zmLQoJN1QvSpac07IuJDzYhY5QhiXfwPW9jcEmYbT38Pked/y9PSjgkTk
	 uct4QGESqki0QRyyPgpixKVuNNCkcX4M0TUx8djTcts+NKQjEKPSfnNTa5IpzOifzSHME
	 IcOPJCcgzmMUqBjJ8ArDEVErwGw69svXzh4hAknQ3KSLWUYHXpVV/s3cL/7VwsoHXcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793195076;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lGqeRLUPxhXO9uZydrP3vvoSiiEUSzuz0owrqbSjOBI=;
	b=gDmo6oF5iEehZ4LS3wYV80r985Rd9L05qkcAkuDHpbmVngESWlpeTvLAWJz/fNxlr8Yq
	 cxe/0LbaYwkSQMYSIrm5K5fWjRAF5u4tk+nBpTLaSB6XjTmuYB/+ixL7+OHJoMjJ27J0V
	 uvVCVSAsFi/IDEFqnS67dZsoMHBdUPkkJDMG88gdkB0vmscKw7QNmaeAhS4D7E3mU6vpl
	 /3hOiFBiGhHMPS2VuGDLsgirvOWg5tmdu25OBoKcBsw+uOv7ik81gC+Zg3Pjk4NPCOXiV
	 fVKpU9N0UjT8oxNdScMfXn7qt409DmpBWNveh3g+ooWIRXL0K5h0eNTAnptE98oj0+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fEUgXLI3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049D0606A31A
	for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 13:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fEUgXLI3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9F21F01825
	for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 13:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793195075;
	bh=lGqeRLUPxhXO9uZydrP3vvoSiiEUSzuz0owrqbSjOBI=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=fEUgXLI3UeSZL4GI+GyfBds3XIO894UoPagUIMogrN9uvnoGgE8anWtmWl1bMj021
	 RjxYy+C38lf+BVMCgK4A3QNk2/a2NclXGABIhpSzigx43sfrUMaBdeDwvBz4seIabH
	 Rj/fNGbcnHIj5a2NNX2YsJ9+hkI0BoNjGKNF5k3ZvtMTvhPOB5EEYX7IqF+C3lLNqB
	 tQtOAhcOeDHHbkDfFTVBZV4yhcf4UAGwn9D4WI54PgtbjqOECKOb19u35SzrQYP52T
	 0IfTVGBKWZm1VnmSIDFR+DpsQvqPlsZeWSIZhyuKIUCjfaPrY7WkWAEgo7Cc52hJj+
	 LQv7nMpmKR/Uw==
Message-ID: <sashiko-outbox-187940@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 1/6] docs: security: Describe the Kernel
 Assurance Plane design
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261028133335.75899-2-ketan@armoriq.io>
References: <20261028133335.75899-1-ketan@armoriq.io>
 <20261028133335.75899-2-ketan@armoriq.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 13:44:34 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Describe the Kernel Assurance Plane (KAP) design.
>=20
> Agents and other long-running tasks act on behalf of an objective that a
> user approved. Linux decides whether a task may perform an operation,
> but not whether the operation still belongs to that objective. Seccomp,
> LSM profiles, namespaces and cgroups cannot hold several objectives apart
> inside one environment, or revoke one objective's authority while its
> task runs.
>=20
> KAP introduces objective-scoped authority as a kernel subsystem. The
> document covers Intent Lineage Groups, the authority model and the
> control plane under /sys/kernel/security/kap, where igroups are created
> with mkdir as cgroups are. For each design decision it lists the
> alternatives considered, and it ends with the questions on which
> maintainer feedback is wanted.
>=20
> Assisted-by: Claude
> Co-developed-by: HARIHARA SUDHAN. R <harisudhan@armoriq.io>
> Signed-off-by: HARIHARA SUDHAN. R <harisudhan@armoriq.io>
> Assisted-by: Codex
> Signed-off-by: Ketan Bhardwaj <ketan@armoriq.io>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028133335.7589=
9-1-ketan@armoriq.io?part=3D1

