Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794602255;
	b=fiLSOSDBhEOx8SGxXmUv5N95q9ffZKXJ2fPTIIDHzLMkNf9Kues4A5z21ValOugyUAXh
	 dh7q4RmV/q7bVxffUWb+S8ifoMQf+F/nbBDpa2YfbH+jPz8JBY01Xe3vZrDUUimt0Hxh9
	 q3+9s2teLP5JlTfseXKJ4VgwqEdvP7M6EIfwyG25R7XEum8Rff8+OBVrnAQ4opS+OacaO
	 lp+ogNXZl08Z0lqlnCvEGn+8slRpKJT3/YXlJD9uUzmqtqd5O6Lsx3uvbATSjH072qZS2
	 ks1nXTF0pE9u5rLxOCS1Y9cbuEc8Ykj8lVLgiNKhlzAP+udlnobcGEPNXrlbEL8Lexw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794602255;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=USFFcYiwsMzO6tacigNJlTVcslIlMDUDpK5QaXg8Qzg=;
	b=d/Xo8qJYw25co4rwoBhZEP+n4jllxfMqN2QnVG9Is6y0M+bPM9l7a61zJ8ULkPkxsOCm
	 qeQXb3RZIkR51saQeh+ddEgbdA3ob+f5VS9SDuEixcI35bB0oO9Fqfg04a9KGI5ZiTpKo
	 yfqcjF5XEtRXvtLNmqkxlZ2yvTzQ4zxvlY/VxBlazb62MdT5QGGZAA9YKeCu5BiFX8vpq
	 ip/RHOBf/oFnEq5zIjOqzimSAnNE4H5A3dhuKhOXfOdE/gGJcnseNVYI8Ww8tvYqa3vz1
	 JUTcfXh/4rrIVPoVkpUCtRaM/8ybcK9q4KHrc8DrwrAsGT2KICWOyjcH4Pr+ldsABqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yh5jX2uA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99180606A331
	for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 20:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yh5jX2uA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F96C1F000C4
	for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 20:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794602255;
	bh=USFFcYiwsMzO6tacigNJlTVcslIlMDUDpK5QaXg8Qzg=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Yh5jX2uAq2+rzOFP4fXTCawXCDg45usDqzKGLlef+OgkOHphEbAgUV8Wlf+CbUMDi
	 AwzdskvnQLR9gn+BBARcCzRzJgGl7ho5V4esSXMibXa9E2HQbge84HWXj+7/gAKXb9
	 sFrSjDcvvkn7Fdu55IBMabV6rg69vBqeAQU9yEOGEp/+9XtOulsDoeN7DuACjP0mvG
	 nwaftUZwq6iD2tJ4cqsA3yL1mDzxikLXyZ16gRPy72TSjTANiIaUGnBajkgfa7QMFN
	 sWrIRD2MOD28nyVnZVlu+tIyaGwvFI0CWF5UqKUXY6kVQ5KBAN7L9+vEKFhQIHbcrC
	 BXeAxT4pUfgeg==
Message-ID: <sashiko-outbox-213658@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] landlock: Add KUnit test for
 landlock_get_fs_access_mask()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261113-b4-landlock-refer-nonfs-layer-v3-2-02d7e42bcdfd@gmail.com>
References: <20261113-b4-landlock-refer-nonfs-layer-v3-0-02d7e42bcdfd@gmail.com>
 <20261113-b4-landlock-refer-nonfs-layer-v3-2-02d7e42bcdfd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 20:37:34 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> This checks that landlock_upgrade_handled_layer_config() and
> landlock_get_fs_access_mask() together result in the right handled
> access rights being reported by landlock_get_fs_access_mask():
> LANDLOCK_ACCESS_FS_REFER is only implicit if any of the other
> filesystem access rights are handled.
>=20
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-b4-landloc=
k-refer-nonfs-layer-v3-0-02d7e42bcdfd@gmail.com?part=3D2

