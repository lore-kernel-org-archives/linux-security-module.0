Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E562A3B14A8
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792343670; cv=none; b=JKD8pY5mST5J0sdDRBEA5uxaUMNlzLGLv6OJA1c82WAyvxINIVMyJXjeYXa66EPKZMxptBmhThQDB5vx0rbZK9v6dkvQjV+tHM2dwjdz3pemgZgDCC/9X6ZfLv2rl6M1V8esCGAjRPLp1x2Alh7IHSSCGU1oLpr2ifkiPh0lC64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792343670; c=relaxed/simple;
	bh=T8C7jfEKLKDD1Ul+J/U1tpl9vMjwwQwZAugHOp6my8c=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=CoIKoQkzC9PNJwgvOK6bFYQqg3n1eXtEEPA1Ac5lh0A5Jap0awNAiqRycxqXW4trZEmornYSbvdvYIIUomIXA9SEtvhmjiOQof4G4hQeMuug9RdcghE8//TKrxr8r6Pt68iUSqy4e4hWEK6NcOEOPY62ws4xf9v+o3EAlAjBiOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+gYstPG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+gYstPG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A3F41F000C4
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792343669;
	bh=T8C7jfEKLKDD1Ul+J/U1tpl9vMjwwQwZAugHOp6my8c=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=j+gYstPGH/bMhtDqafNMNvkKuYcu+wqWWy/4bd8AYcIeaBWyymVTLQha5c7BUrPi+
	 ghEADGbE8Gy3H+Vo8ZSKnw9y7pBK8gnfSwtk630c5Borxr9VM1fCOLxVwI0SAYxrxn
	 jS4vmKuTzTaguOwbCbBYk1E7iczElE+zeBwI3KMfhVoN46JMiVFiQ16dt6UqH9IW3Q
	 ky0lVeErGT+kxxcCjtqTkI9HG83OphheNS8GicPWhoyaIu72IzN7DKJL0seidgxtQI
	 sxxhGG8Y7y3wM+1kZAD30MP/MzrgoUIiMrY1EHUKdM5WfYEAxEfRgiRa25RGMD6b/D
	 XS2hvyCLHzYQQ==
Message-ID: <sashiko-outbox-176310@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/9] pseries/plpks: fix double conversion of write
 and remove flush errors
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261018170844.491252-2-ssrish@linux.ibm.com>
References: <20261018170844.491252-1-ssrish@linux.ibm.com>
 <20261018170844.491252-2-ssrish@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 17:14:29 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> plpks_confirm_object_flushed() returns zero or a negative Linux errno.
> However, plpks_write_var() and plpks_remove_var() pass this return value
> through pseries_status_to_err(), which treats it as a raw hypervisor stat=
us
> and converts it again.
>=20
> Convert only errors returned by the write and remove HCALLs, and propagate
> errors from plpks_confirm_object_flushed() unchanged.
>=20
> Fixes: 2454a7af0f2a ("powerpc/pseries: define driver for Platform KeyStor=
e")
> Cc: stable@vger.kernel.org # 6.0
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018170844.4912=
52-1-ssrish@linux.ibm.com?part=3D1

