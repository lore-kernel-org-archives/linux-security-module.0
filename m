Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793111601;
	b=HAgajoG3e+kmvPZYWVoShW7yFcvamiksJiuLqY3rRmcgyy7oBka4IODScd1+0/DxYOfg
	 BzIvlT5PWKjNB0xXm/Mz7qGv9UtttfAc34A3rk6PnALDZInIVKcVc3Egz1oLRb7pwEVL0
	 LqdkJ8Gce0ioBSr8Lj9AKeR21cV/DfTcnR8fVt2tmoLIDmxRMO1XSjlpTfgsfVKSSZvUJ
	 tFMdPfcxuKmdxIgPzZUyMNhpuo/O26XN6G00Kwlm5pipqyM+jcwfqUcxhRHwoh4QxqvK6
	 ywPr/Iiiaum1ovfqKAcaFY+rVlC+VTg1QonKIYPccU2+0RoRjbW016spFbWcmlSNvcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111601;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=e8XZq2B0bowP87X9ApT6Ip1cXgl5AqijW1p9cEgDehE=;
	b=0P0TQJXGbxDNYOPWtez8UsiGXjmiz+iNvKYRpn0Fqnq82y7Ps0kmtInoeIchoiosRg2p
	 Ph1AqN+R3dXYtgYKc7m+FkMJtSt1bU294zfUkCTYj9qIGeOavX7cK9nRgUglH/C5W1HK0
	 Mb6sA7zeR9ufDYMddnynrfz9I2/RsEuWwLBGd3KRgk2k4QfvNEGzKj0BOPoghKWsaIBqX
	 x+grVhv4o0LlCc1di5J/SynSme4DR6rvF5lIbDzMpRH48ie7Cj8EzXomXv8x6jk96EXra
	 tlyA0QkxGCcWGzF5+YHSKssxp0TeKxwmUPZJ6lnMV5iJ+Nx91aN5oOYA+L12Fe5t+og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k3aArWGT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D87606A320
	for <linux-security-module@vger.kernel.org>; Tue, 27 Oct 2026 14:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k3aArWGT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7428A1F01825
	for <linux-security-module@vger.kernel.org>; Tue, 27 Oct 2026 14:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793111600;
	bh=e8XZq2B0bowP87X9ApT6Ip1cXgl5AqijW1p9cEgDehE=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=k3aArWGTlnMpX5Db8dMFmsV6AVm57eeOcAAc+9Csym28sbW3ZC9nSk7hILSuOSCxB
	 m0jxDxssp33vyK3ZqzQvdKoo6lF6eljbtkYQfpKdUPi0XYS0zUbn9oIk10spg7Xv3d
	 IRaDF7hCa7mHz/y8r/orvfXhXhYSDsb8T0LLFsPnmrrDGlrm78m2P7idlFawPKzIam
	 GAMO4D+X9Cj0sZgYIegTVdI1qE3rLDIGcF4/zD30xPae+DRkXYUU+WtK+PatqOzSGb
	 1vvRdSF+BEq9BBQKJ+g14LmRv9Fj4m+5x51viaBpp4uFWrpn2dYjAZXH7q3P9gMQfw
	 bLOxEPHLibFZA==
Message-ID: <sashiko-outbox-186726@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 6/6] selftests/namespaces: test the CAP_SETFCAP rule
 for user namespaces
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261027-b4-setfcap-userns-v8-6-2674adc63f3c@toxicpanda.com>
References: <20261027-b4-setfcap-userns-v8-0-2674adc63f3c@toxicpanda.com>
 <20261027-b4-setfcap-userns-v8-6-2674adc63f3c@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 14:33:20 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Add tests for who may map the root user of an ancestor user namespace,
> write file capabilities that are honoured in an ancestor, join a
> namespace whose tasks may do so, or attach to such a task.
>=20
> Each case runs as root in a private mount namespace with a tmpfs on
> /tmp.  It sets up everything but the step it tests and fails if any of
> that goes wrong, so a refusal comes from that step.  The ones that must
> be refused are the ways around the rule that the preceding patches
> close: setns() into a namespace created with CAP_SETFCAP, a uid_map fd
> opened by somebody else, pidfd_getfd(), a writer inside the namespace
> that gave up CAP_SETFCAP, the root user of an ancestor mapped at a
> non-zero uid, v2 and v3 xattrs written after a privileged task mapped
> uid 0 for a namespace created without CAP_SETFCAP, a joiner of such a
> namespace, and PTRACE_ATTACH.  A task that joins a namespace gets
> CAP_SETFCAP wherever the namespace's creator had it, so the setns()
> cases end at setns().  The ones that must keep working are a task
> mapping its own namespace, a privileged task mapping it from the
> parent, unprivileged users nesting namespaces, joiners that have
> CAP_SETFCAP, file capabilities in all of those, containers that don't
> map host uid 0, and idmapped mounts of a container's rootfs.  Where
> file capabilities are written the test also checks whether uid 1000
> gets CAP_SYS_ADMIN from them, by running a copy of itself.
>=20
> The idmapped mount cases skip when tmpfs can't be idmapped, and the
> session keyring case when the kernel has no keyrings.
>=20
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-b4-setfcap=
-userns-v8-0-2674adc63f3c@toxicpanda.com?part=3D6

