Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856A03F4DF8
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792344187; cv=none; b=VJgDsiyLrvdYEzmeLev+LOytVU1r4i5gmwE4sgJPit90w/IrV6eq3/iZY95hJvnBawXUEPhcu1WwJtez5KGj8LrqV3S/22jKZ0g2JOYWv+BOOfh8hATW84WHaz2hHzAN47FyPLk5Q4WeUKYa/n7JxoVH3qUQ5V6OLbYsp3Xx60E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792344187; c=relaxed/simple;
	bh=gA/xaB1CnFeonuMxW8PbNuAHm4Uuya9uZuNe6nMJoFI=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=DB4y9iLM2YrK7vIv4cehNR9XhAEzJumi8pOEGEkHdiAap8kLV6uRWoeHxY48Bz/F8nqlmc8V+k3TtLuVjnFO7RlcJOUWNiRIpbaOuGlXYiuapuL2wGe9K5N4sQ2ygANkXu3179oQq/spnzxRHhGs85EsY0Jg0j60ybBO6l48ooc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9Sj1QcQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9Sj1QcQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADE81F000C4
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792344184;
	bh=gA/xaB1CnFeonuMxW8PbNuAHm4Uuya9uZuNe6nMJoFI=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=h9Sj1QcQZqKoy/2p0zMXiO8n4GjAuf+HVXSLsq6YQjudsoYjbo4QkWkg5XzLQX3RA
	 mz4rRwvlucfK9RFYN5OETtzvF93jXK0dOuhAajHi59wBBJHFzqCGwtgNN2EO7tO4QL
	 Zg8yPg6Yvu+sT9mV3FuIFoAKx7zfu3H1UvvUovQRADzCl0VXim01OohZTtLM+JqD9g
	 T0BHGRdiskIpqAR20pvzqthlnrw/gjwT3Kmj6ArPqEo57O4GwXYQASIiT7FFMLge1L
	 8fKegmu05jdKJHHJtnydKcw+WLPYMYmeRz5DtbFMqgQzBdRdv5yJIELVh339OvqgUE
	 6nuTWA5iGvQ/A==
Message-ID: <sashiko-outbox-176314@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 7/9] pseries/plpks: add HCALLs for PKWM wrapping key
 life cycle management
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261018170844.491252-8-ssrish@linux.ibm.com>
References: <20261018170844.491252-1-ssrish@linux.ibm.com>
 <20261018170844.491252-8-ssrish@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 17:23:03 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> The PKWM trusted source uses a single wrapping key per LPAR, created only
> once during trust source initialization. All the wrap and unwrap requests
> are bound to this default wrapping key.
>=20
> Implement H_PKS_REVOKE_OBJECT, H_PKS_UNREVOKE_OBJECT, and
> H_PKS_GET_OBJECTLABELS HCALLs to enable support for revoking and unrevoki=
ng
> PKWM wrapping keys, and for retrieving wrapping key labels. The label
> retrieval operation (H_PKS_GET_OBJECTLABELS) applies to all wrapping keys
> including the default one, while the life cycle operations
> (H_PKS_REVOKE_OBJECT/H_PKS_UNREVOKE_OBJECT) apply only to user-created
> wrapping keys.
>=20
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018170844.4912=
52-1-ssrish@linux.ibm.com?part=3D7

