Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03C032B102
	for <linux-security-module@vger.kernel.org>; Fri, 25 Sep 2026 19:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790365564; cv=none; b=Euej/21W916DlLy1Hb5vSHHtPjP1zOctTwMwFArgfY/Pd0K+U95jtW6RD6fGd51MMrNNcg7BwTtxIu0oVNimcj2tt71NJLZ4jByso84QoRwH7XTQukktikO9JmqNkD87L2Z1QZimqHps3Ks1OePfTKp5vfUtd59eMFueTZewHoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790365564; c=relaxed/simple;
	bh=D7EI0FI1Mf74eIaThcrC46v8Yd9yRwo+CAO0sQMStBo=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gE+kQw5nPvTgW4vjdY9xY+T1kRFjbEFZ+Xz5bBmEOKc41hyLSEM9kL1f35wYUt+Ss4A6qm/HX6ASqkzcAPLMJ6QYtmVx5ndUPH/ktbPjVXtG3HVCWWkHcVqt76kUDA3Rmr7u+8iSLPQn0gy1F+t938WNC8JqLRlueehNlk643mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oi1qt2W0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oi1qt2W0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB5A1F000FF
	for <linux-security-module@vger.kernel.org>; Fri, 25 Sep 2026 19:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790365562;
	bh=D7EI0FI1Mf74eIaThcrC46v8Yd9yRwo+CAO0sQMStBo=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=oi1qt2W06McbKeVmsXxx0GjFKaarvO7vbBJeHMtV8rX8fSTCRKP8R/9FpxM8PGab7
	 oFCng+j9nV+ZH/Zdal7TTxaQZNCDXkUfznVXqwhsnkqiHy/TjostqfuubbdPBNVx8v
	 985Vcljy+esUJG7JOFqvGnSk4lZ4qGVtlVpv8Qmqqt++Ji4OPphpkB+KXEcnwYCFQr
	 xgbDUCfFBSrsvznKKY9dd/f5FGK//g/bIbBnuyFmbexmkwtHl1Q2eZj3yLHJhnYoNH
	 PLYDlwo01uxNTEu8pu275sow81v7sS5ZdzQRlQrOCEQAGLuaj57w4HUgUCb+1z9LPW
	 FOdVZvJUXe3cw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] apparmor: check connect permission for SCTP
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20260925193842.1208132-3-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20260925193842.1208132-3-Jeremy.Jean@oss.cyber.gouv.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 19:46:01 +0000
Message-Id: <20260925194602.5CB5A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> SCTP can start an association through sendmsg() or CONNECTX. These paths
> call the SCTP-specific sctp_bind_connect hook instead of the normal socket
> connect hook, but AppArmor does not register it. As a result, a profile c=
an
> deny connect and allow send or setopt, yet a task can still create an SCTP
> association.
>=20
> Register the SCTP hook. Ask for connect permission when SENDMSG_CONNECT
> or CONNECTX creates an association.
>=20
> Fixes: 56974a6fcfef ("apparmor: add base infastructure for socket mediati=
on")
> Assisted-by: LLM
> Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925193842.1208=
132-3-Jeremy.Jean@oss.cyber.gouv.fr?part=3D1

