Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890117;
	b=rJOhtgGJmiK1oa6et6czNQvP8izEINEhmKg4p4RMhgZydH6DVmozZs4BXmWCLBYgYDS1
	 biYiWRXA3o6QOjI9ItTdzU6cFAXvXo6VDFx8nMm2VKEOSSOO6VaiWPdrqdWH3aJaj8MKc
	 EelZuL+su2D7UDYcQ0K+EDzSfoKwwluxy2nIr0tKYOL7kjntdHMDTKHzNSxGq88Ni2Ocq
	 CSrRaN5bDjReeHE5AVCPxBqIQ6Q9vtZv4VM/ylWhmLGrx+0bUP8+KMrFWxPJsHymwKksI
	 9nj+g/Jj6GBYIBgGEXgZcIipYxXX99MgkbMyxAW78huZk4oWhiHKsIl5KOvieMdKBzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890117;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NLdcT6CuvNmgnPwzY4pBOr5RYz3TKHXEnYcOvoJgVrw=;
	b=t0006XleSLRzU0F496fTYNJfFDp8qCCzJFzb1O48KM1/6+fQ4U2b5PGFmKF3gPt3cPkK
	 0s66uEARxy/MmXJ8pTOkznve4PvFVA/+N/JSrpivPn0eHPIxz7gPoEs/pDDZP5sYFplLE
	 xK6g4sEt34+lm1EkOo5FcJ0YiEpHw8VgFIlDMmUJmG3wvjtkjqYAwDwTq+42sSM7uBd4j
	 6TXxzwm72j/Co01Sn5IoImmLxI9mZwCpcDzSlzNpDPsTw91EAoiI0/wiMzAQlzsc7YeF+
	 Hzd6GfHrzQLgnvBX0zRC3i2MVo+MtfEMIlpcSZjvbkyxhEZHYtvulKOiSXLLaeIc9SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VT3bHEom;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E00606A31B
	for <linux-security-module@vger.kernel.org>; Thu,  5 Nov 2026 14:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VT3bHEom
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA821F000C1
	for <linux-security-module@vger.kernel.org>; Thu,  5 Nov 2026 14:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793890116;
	bh=NLdcT6CuvNmgnPwzY4pBOr5RYz3TKHXEnYcOvoJgVrw=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=VT3bHEomvF7Gc384RYDsWY2QJx/vVYxwdeTSK0NhjPoQB4XvdREgYX5AZyicVruln
	 p7QfZ1vRzSA6IPi88KHx7C79N3UIJmY+o+xBSF48cPOHlyu+eyEyuGr5TWHRlpPkWc
	 pVPMlBpOB3jn6ITfSRrLIw9Q/N8EUJSkemuCkdprKlzIejNlgXqZDPNDcQz/0VvFl6
	 ffDwvGZbkxrgHt7f8x6nndMDj103YYeBsKQ4aXfRqeIueL74GqtJFxohExgJVSFgoG
	 PVONr252YkVkaChSq2qkuxacNhEQSXIviKE3SwPmKEQIPESN+uSJX/beQ9stVtVORb
	 HK3xPghZRt/WA==
Message-ID: <sashiko-outbox-199266@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/9] pseries/plpks: fix double conversion of wrapping
 key flush errors
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261105144320.357260-6-ssrish@linux.ibm.com>
References: <20261105144320.357260-1-ssrish@linux.ibm.com>
 <20261105144320.357260-6-ssrish@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 14:48:36 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> plpks_confirm_object_flushed() returns zero or a negative Linux errno.
> However, plpks_gen_wrapping_key() passes this return value through
> pseries_status_to_err(), which treats it as a raw hypervisor status and
> converts it again.
>=20
> Convert only errors returned by H_PKS_GEN_KEY, and propagate errors from
> plpks_confirm_object_flushed() unchanged.
>=20
> Fixes: 133aa79e211d ("pseries/plpks: add HCALLs for PowerVM Key Wrapping =
Module")
> Cc: stable@vger.kernel.org # 7.0: a2df535d9dd9: pseries/plpks: rename the=
 default wrapping key macro
> Cc: stable@vger.kernel.org # 7.0
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105144320.3572=
60-1-ssrish@linux.ibm.com?part=3D5

