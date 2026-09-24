Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A251E54788
	for <linux-security-module@vger.kernel.org>; Thu, 24 Sep 2026 06:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790229796; cv=none; b=nufN3BU47vtTGZrZZxkDcmJcjVVg42AYkpbztarzA8u0HagqeccCJ2fkn5xGI0/cD+9LIvfwv/sSd/pFU1sWb3n2LNAy3UMt9Y8uQ3pItnfM4ruOd3omxzQ4czUf2FcWA979YJCT/tCRKpuViVZwwGOhLPAb4kOIFcUOW5yKuYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790229796; c=relaxed/simple;
	bh=B7VZYikwNxrffkVqJ62SxYv70dlCuVCZbAminLOXP74=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pPnF6qmacgCCx8NLj52vmX9hMhwioHkU2DnwK8Tdluoqnrh4JLNYH10ksuReolbUcUk47DHuPEAeNXGCI4n1w7qFDAJ67rPY6AfVhLul2kZD+eBW3wQ/9UR5KYaZiI4fJYnf5yw5uC2U1CYE0IWsNSNsdRNpklkDE/sh9vppY/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oA7oL2Nv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oA7oL2Nv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C33E1F000FF
	for <linux-security-module@vger.kernel.org>; Thu, 24 Sep 2026 06:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790229794;
	bh=B7VZYikwNxrffkVqJ62SxYv70dlCuVCZbAminLOXP74=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=oA7oL2NvOZEVtB6Z8Du1zIyb7otffmZ3NjN/eljPm7fyKvtRE52l7FdiIvx6b/kV8
	 AfplRe3RxQqfOez59mlfzBAQPaM2N+/xJaC0G1Gl16mesS5YXLz4NV6F8ZRu6rZopd
	 PLlj7ssn8v531ZqfdDAUDcdmZMG+747DH6NnsTtn5loFvPTLO0YZO8kt2BiUceF0pV
	 h2xcjvuiXIcgSTbxk8sknX2/JTa9ruarXXqh4DOJZa9E1MhC5vrhM9I1lSHS6Jni+9
	 k0tJzErbUgg6knlOOpMKot0sxtpL4AGgF73yn+fy+ykme4m/nfzZaFXe6C2E0tOkE1
	 ZYvbflXIDVXoQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/2] keys: Reject keyring creation with overridden
 credentials
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20260924055521.1981957-3-jarkko@kernel.org>
References: <20260924055521.1981957-1-jarkko@kernel.org>
 <20260924055521.1981957-3-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 06:03:14 +0000
Message-Id: <20260924060314.9C33E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> If the current task is running with overridden credentials calling
> commit_creds() is forbidden and triggers a BUG_ON().
>=20
> Reject keyring creation with -EPERM when credentials are overridden.
>=20
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924055521.1981=
957-1-jarkko@kernel.org?part=3D2

