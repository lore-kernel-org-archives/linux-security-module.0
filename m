Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66CA3DD875
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792343791; cv=none; b=AOnWn5qcjSYAMzBsiUI/7zR8L3fRyaKwqNZ5kZXmRrEYhXEIslPB2QK/p3xISSzT+P0gV0soVYxvh0FfCDUP1stOAMQF9Inujk+bpS9or9cHv1cy/VcdaMcoX1ZDnww13w4hVqr8ttagcGmGeyrkGks7Dd+TI3672gl0Nvyh/6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792343791; c=relaxed/simple;
	bh=7TKs4fnhUq607W+ZZpiDyb+sO1pIF/SXK4nXlqGJkCU=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=eqTvsbjtTADCl/rUfqLG6U1KsEXiNc5bcMA7O3qJsstpWLRyzb+CynW75lEdHbCRIeaOAwlhXQ+KtT56lrb2QlpY8fE+sB8PDnxV7YgRoNuloz0BW28+HOGtwX1EkmIYH970enlBTDRM0AH0dR8MMxBN53Kjyo3L1jdwFlJhApI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkpoGHRM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkpoGHRM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A5B1F000C4
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792343790;
	bh=7TKs4fnhUq607W+ZZpiDyb+sO1pIF/SXK4nXlqGJkCU=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=VkpoGHRMjrjcq8wsBx1OnUjVkCK25pdWHR86pb4rcN9wrK/soTE1D5hvcRZgwiQvw
	 mwIReFaHdvtkbEPAKfOLLQV/mOYj/JCqgwb5ybx5ipbrLMTlxIlzEDRAN16ELyRv43
	 IpR/ikSh0QBH9+zsuwUwrqqr+Fw+U2ejX0NrRO4E5GqHZp37VtsRGXWqGYZ1BJCG0v
	 R+6f8von3BQ2dRUCWXeY+6b5TEN5Wffctv42C/IrAtpk5+wrQgLYt52LM9Ytp2WepV
	 Wcn7a+o2zcn4QLuFJObvtumPtHAsUxCiwVqJpbv7OKuCPsP9pPM4I4hsLiOwn6lt1M
	 GZu88v5aCnDCg==
Message-ID: <sashiko-outbox-176311@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 8/9] keys/trusted_keys: enable PKWM wrapping key
 selection by label
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261018170844.491252-9-ssrish@linux.ibm.com>
References: <20261018170844.491252-1-ssrish@linux.ibm.com>
 <20261018170844.491252-9-ssrish@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 17:16:29 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> The PKWM trusted source currently uses the default wrapping key for all
> seal and unseal operations. However, PKWM supports multiple wrapping keys,
> enabling better isolation between trusted keys.
>=20
> Allow users to provide an active wrapping key of their choice created
> through sysfs when sealing trusted keys through a new wrapping_key=3D<lab=
el>
> option. If no label is specified, the default wrapping key is used for
> sealing.
>=20
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018170844.4912=
52-1-ssrish@linux.ibm.com?part=3D8

