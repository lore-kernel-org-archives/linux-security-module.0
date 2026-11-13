Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794587022;
	b=JUHvjJV0Ppqg8OTja2ZP2aDkrDKZK67qpV85Nu3lc0fF92FKhhEZGvyXBiWU0mQIsCUD
	 GaTw4EHCg0riaIAyfZrmWYNklCg3DTLP529EN3dqYCU+tJveltdm6pOEEoBXO+oaatzM2
	 vWIBrKBGusjlVJ5j2Vrk3w05YvmOBzez6kTYfO1YL9Uf2fYAKLDnw3N4JhklSBy1Rn0JW
	 nICqbiCPkH8ivaPy7QEmD0kCsSseek9Zyj66MaAloZAfd5ZzVpchcbH1geoFHqxO5+gl8
	 B0/4vcdLHDDsUQ5FkWmbS/vDXUy+m1+wna08Xvfp3cG/750R0FXWAzqLM5KbF0td8IA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587022;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Wybe6/t4TBPK/Mdb/EBU8sVeeHPQ53SC5zJh3UQ9Hqc=;
	b=vWSUH1QFX9bYLemIo33EuEeNXG5ASthSHzD2+xxlEYS9tPwQl7lQcc3yoXh1tQJpgtF5
	 NhfHrWk7xnsNAezdKnWaXYFykQmEA0DLeZdepETixv+i/2O9hur5PWT/S0tnW1eIEhYt2
	 BvP9oKWm4MjZRHwpKH29vJFWs3JzE++p9dXCEv3pdMhuumCZIv90Li55H2hF/i9waFyOp
	 LFg26tdNpg3zitAmIff/Y6e+InuSIvCaJzGs2MwpTD3ViVzzqJYso6ZrdcfsO4LlhkLXs
	 0gP7DSxVDudZ8obYU37KQjWGhhsD7YJXHOeXN8UMypSazW0rua6QyaNfgfH2NX3fe+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MM7NeMXi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46356606BAB0
	for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 16:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MM7NeMXi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC3FE1F000C4
	for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 16:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794587021;
	bh=Wybe6/t4TBPK/Mdb/EBU8sVeeHPQ53SC5zJh3UQ9Hqc=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=MM7NeMXitRQ30m6MN0FrKzz6lx0H0LjWw+cxWDUykg+SayPCcabsgjSdViSuO2bQq
	 AtBAoMIOSud/AEynfW21YoRmrrIDko7y1IgYHR/vEWB7OX643Fwoxc85NvTYyYQOWt
	 goG1c6TRzF8IxsLDbaxeTkX1oN5lQoDTem31lfKuKFpKq79SydckGIMdgxMtzEM3Pa
	 kzXnMTZPHD6QfpPdsecNHJq167t/eQeT4rp0Bp4vGebf0Al/jq+CXpJLz6CIscmnF0
	 04eLS2nnV5iXvQCwKFcSKDnv/uRa3apVwy7jIy4S+ak0zlFg6t4UoRP7/bOk30xZWe
	 FelG7SXd6IcxQ==
Message-ID: <sashiko-outbox-213189@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 3/3] lib: Remove assoc_array
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261113161836.3587552-4-jarkko@kernel.org>
References: <20261113161836.3587552-1-jarkko@kernel.org>
 <20261113161836.3587552-4-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 16:23:41 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> As assoc_array has no longer in-kernel users, remove assoc_array
> implementation, includes and documentation.
>=20
> Reviewed-by: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113161836.3587=
552-1-jarkko@kernel.org?part=3D3

