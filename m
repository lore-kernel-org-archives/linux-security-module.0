Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795117010;
	b=jo8mp6B9fUIC93wbBrcwv94/2p0E7aPFeRRIggsVUXRazw7OpAE4EqJs5qZwE4jQsdSn
	 HEUMJw5Cz/T0g+i18xJY0ucSQw+7A/KjEFmtNFY+vgTV31EpVyY38ZBgblwnN+2dl73JN
	 VqaPevfKLmD6q7nbCz3b92VxDmAryASFxjOVvgtGcNSd60yq7YN9FLp2ZxSCZgKFBR976
	 SgQQnzg05yvWAa7l/eXmHIOLNNTDa+VMZrLKj9wLwpewozsTqAA4cn8C2VDZpCUDN8FGI
	 BrhRLZY1o/3Xl3rZDt/dFBvzfaaOBWhVU2Xxlvfq0iqO2WyHUJdKi9YntxsIr7Hz+ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795117010;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vTTst7jCrIVgTW1Y35XVQIN0ypv3AJvUk8nAU4THMaU=;
	b=AGaaWhTIh9o4ah2PBBrurU6na+nd6H0iXDVKHIkHDfLscA4Cke7dE/iW5CW8vyMSamZP
	 Ol2ASqIozRzjO+DRpTs/brXuOeLhb2sm5tnzYjvDLSRAzx5o501xGfWgPJFZ12rouckfy
	 0h/0N1NHFAnu3zQJxqw4LIpoZkl0VzREY8sYG538LZijplDPTpW7x2hbn4ks08YPilUgW
	 alQU8vu0FS1556fv+oJwrnAZPqu9oHbeEumDBPDQNrBqMNVPV7fLPsjl6oINUdrKaitaK
	 E2d2gS5aV4UPkNQm8l+kbyivIJ0p/XbgQGUwLBQpgcKF3LHwgqZDL1h9d3lMsp0t+bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OHGK2gIl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A628C60A2606
	for <linux-security-module@vger.kernel.org>; Thu, 19 Nov 2026 19:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OHGK2gIl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 710031F000C7
	for <linux-security-module@vger.kernel.org>; Thu, 19 Nov 2026 19:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795117010;
	bh=vTTst7jCrIVgTW1Y35XVQIN0ypv3AJvUk8nAU4THMaU=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=OHGK2gIlwcPkEP/7e8PCxNgC1s3EwtwoAykcrGL8ZBg/MKIoDDEHC3Et4eqzY8qWp
	 bYHASPRGhs07WGdYkY8psCxQmuSzElSMk7Nm8Zfi9F06t/RnZ0OwevG8B/I3kOUAVL
	 T2fxbkLtgsWaMTVdNISP0fgmMF1cvfwX4VqD8PcBUFp489n1vjJMqVJhKwF7oak7W2
	 mqJ346cxDBJkLqqWjvOJ6bdWUdg5yl7BHmgSuMiKYBbjZmmSUCO2VZrEPU+7v6wu+i
	 Z0wTii/bwQsfQMpumZj1sz4kz/j9WpqWaovc6mJUcMSTLTQ5MrnqYOnimnSJhSpnPv
	 kowTZjJR36kaQ==
Message-ID: <sashiko-outbox-223946@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 04/13] rootns: Add rootns_create() system call
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261118193539.240065-5-jarkko@kernel.org>
References: <20261118193539.240065-1-jarkko@kernel.org>
 <20261118193539.240065-5-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:36:50 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Setting up an isolated namespace environment from a multithreaded
> manager process currently requires helper processes to call unshare()
> and pass file descriptors back over sockets.
>=20
> Add the rootns_create() system call to allocate a detached rootns
> instance owning a fresh user namespace alongside dedicated empty mount
> (CLONE_EMPTY_MNTNS), PID, UTS, IPC, network, cgroup, and time
> namespaces, and return its control file descriptor. Finalize the nsproxy
> time namespace and pin active references for the lifetime of the rootns.
>=20
> Co-developed-by: David Howells <dhowells@redhat.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118193539.2400=
65-1-jarkko@kernel.org?part=3D4

