Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B64D528427
	for <linux-security-module@vger.kernel.org>; Tue, 29 Sep 2026 13:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790687200; cv=none; b=NGLrezpB/Zyp8CjZ/n/xRGG4FiQEmpnhjAUVEYSuPhm3JmmCkFbMO3MEkqO/YAkE1LBhgl5wFdHl41iiRD0sjUe0EH5NMjatfmBoBFFJxEWAeGupeRetpjsPObs5izUYAr9u9fXBQYIMhiJFlcHXnmpBG0tn63DrWIyY58X+kXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790687200; c=relaxed/simple;
	bh=J9Lvy7EN9YNlaZsRXrObQkDQiEJR14YWGYysntq9UDs=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CmZm5+jPUlvs9Y7Y1omp8PwZj2+sOz9TVaN1AmbNKrHenXHHR+M8V+atBZ944dw/mWBHMGnfg7ZRzuIzFKAzvmxNxDxejkoBvGjQuHJy0S/eQ95/AyrFTjTiwd9f8jKlL5ZOx291HLZwgGx8gfpTVsOmKfeBFjQYIYWyjlI8rZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCVtq8rb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCVtq8rb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 788B31F00899
	for <linux-security-module@vger.kernel.org>; Tue, 29 Sep 2026 13:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790687198;
	bh=J9Lvy7EN9YNlaZsRXrObQkDQiEJR14YWGYysntq9UDs=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=eCVtq8rbiVu11fW5hNyAdlD8uqAOHPCY3ZqLOHOdzds8f+mz9WE6wiLXV8KXz2rnk
	 Z2F2KvI4dwXxLDjBv1CEVzR8zVkbtgctalxOxRSaVqoe4yF7y3VVonXTUifPU7P+mv
	 DsddgxtJa2Ux55dqJ5QX01vWuGhcZJIl2EUVKsV68l7lpc4/M6ECQUDckBJrRBp3Ke
	 mSOtsKusOXTeA8bZG83cAAhnSTNjkYKovMJgix2THQER8UNi7xyn5wYNYLdRX+lZfQ
	 31daK3n8ry8vQm/e2oHawxtgo3XR/o+X7CT/zI30jEn9826FDt3QqEGqbNfaH9pOMe
	 GpMDuDxOLVt1Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 1/3] capability: Move mk_kernel_cap() to header
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20260929130200.1638343-2-ruanjinjie@huawei.com>
References: <20260929130200.1638343-1-ruanjinjie@huawei.com>
 <20260929130200.1638343-2-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 13:06:38 +0000
Message-Id: <20260929130638.788B31F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Move mk_kernel_cap() from capability.c to the capability header file
> so that it can be reused by other security modules.
>=20
> No functional change.
>=20
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929130200.1638=
343-1-ruanjinjie@huawei.com?part=3D1

