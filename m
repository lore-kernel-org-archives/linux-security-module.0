Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F5E3C4B6A
	for <linux-security-module@vger.kernel.org>; Sat, 17 Oct 2026 18:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792263249; cv=none; b=qkcxdO+5rl9lyimYgdP7EFIsVt8m9vszO203O7pYtK/t6C295GvAEFyGsZsHKxgmQ/OJpT2UR1LDgvRUs2yt2qbpLQj4gKvmoOQaSaSz4/jp7tRU2yaqvpucK4XLEvqFKUniiaCjkDYB1oVlHqlsl04Rd5QHKlMojqZRYirLyko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792263249; c=relaxed/simple;
	bh=qqccw6xJqNwJSMs+9dhbjN+HUuvZ2oa9f6zMVcFzT3g=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Zj0Lsv9mb8rIV44zQfmVQ5ZsDMuyveQ+pA7xRfsO2MM61gyII6QwSHU/hO5bxG6GpknF5jeen7b5xe33Y9H0ZQfMP43bI0qgOkLPs3xBklILIjlzpvTSA1OL0vriEvdIkW7PTYm8U1v3XmWJdz0eh5L0voW2i1VZM2wq2mBkTLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXw20Exa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXw20Exa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C947E1F000C4
	for <linux-security-module@vger.kernel.org>; Sat, 17 Oct 2026 18:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792263247;
	bh=qqccw6xJqNwJSMs+9dhbjN+HUuvZ2oa9f6zMVcFzT3g=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=gXw20ExangQpxCl04XSCtTaSfu7wMuQwvkQ27fLHKB/iiCLLl1NrV/9CybBt9Lp1e
	 zLGTlIbV5EVdVzd4TDao+Hu9hWOoKjuJZglUOe5c7QBLmEmJ5fobN4wI/TM/8uPRZT
	 vHkCNALgWNTXN4+X+/P/A0G+0skAbvt82qzaLrj+siT4pef5gG7i667ot3XSCTikoz
	 teSO2pWMHv78ANMmj40+1hFqnxE7kZzoyHl8Y/zDL3xQXemUHbiWrsPr7wmyoJJEGm
	 1ziqflGmqAj/jymzanr22WyyOSu2j1pw/XdABjnN80W91W/5qyh7LHRzNlLmieuGcz
	 y12AKVXzuiRZA==
Message-ID: <sashiko-outbox-175766@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 7/9] pseries/plpks: add HCALLs for PKWM wrapping key
 life cycle management
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261017183853.596052-8-ssrish@linux.ibm.com>
References: <20261017183853.596052-1-ssrish@linux.ibm.com>
 <20261017183853.596052-8-ssrish@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 18:54:07 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017183853.5960=
52-1-ssrish@linux.ibm.com?part=3D7

