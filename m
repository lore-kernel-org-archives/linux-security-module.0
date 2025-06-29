Received: from smtp.eurecom.fr (smtp.eurecom.fr [193.55.113.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2640DA920
	for <linux-security-module@vger.kernel.org>; Sun, 29 Jun 2025 23:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.55.113.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751238980; cv=none; b=UHI8A/UrUac1bXZuRkwIYjsUbLrAPrTr50TTukFNCwxHV9uvOPglJ8p1Cg1KVK53KmuaAWeYS+kc4u0D0F42jgsxqrZmOWd/ZtQAb1cN5Ha9uMD0Vg2bysD8/xRGQhgoduvoRj3UzwFGejcasZaiwJFqNxWfXd2m26dDWeYewRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751238980; c=relaxed/simple;
	bh=MYkfBgZHAcegDmd4BgmC8D9IIjLscGPgAHW26iid2Ac=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=Dx3trBiFOZDLpwxgLybEcEvMwPn6kd3hrgUidOBrAC1xn4ekAB/omDYTjSwrSYFEuRC8cw0AO8AWwiGTlOgvowChyHwv5IHBhU0MS3O9HuAAuKf7iAfa4GWk/EeISEwswXtIKvwuNLQ5Kx/pcb3nHf0btOXUwHBsVakMF6L8yNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr; spf=pass smtp.mailfrom=eurecom.fr; dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b=Tk/BCM2s; arc=none smtp.client-ip=193.55.113.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eurecom.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b="Tk/BCM2s"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
  t=1751238979; x=1782774979;
  h=from:in-reply-to:references:date:cc:to:mime-version:
   message-id:subject:content-transfer-encoding;
  bh=MYkfBgZHAcegDmd4BgmC8D9IIjLscGPgAHW26iid2Ac=;
  b=Tk/BCM2sMamsTiNIMnbKe88SQ9eNxad3J+Z/+mGz8ndxYAzxv6Sxpmed
   x0K/WI3XuHbb0bpGZ6w6Hf6/ne9ioYgBvR/xBqAunuiGcyFqQC7mmfnug
   qzSssYn5uMAYwaCJ2aYRrajZvYhxIfmzQ8aqgFjr6BKk3QkB3LDhnmD47
   E=;
X-CSE-ConnectionGUID: qeqE7un9QOyWYlA+xJrp9g==
X-CSE-MsgGUID: 61+UfUMAQ+SpFnDErQrYzg==
X-IronPort-AV: E=Sophos;i="6.16,276,1744063200"; 
   d="scan'208";a="1976226"
Received: from quovadis.eurecom.fr ([10.3.2.233])
  by drago1i.eurecom.fr with ESMTP; 30 Jun 2025 01:16:17 +0200
From: "Ariel Otilibili-Anieli" <Ariel.Otilibili-Anieli@eurecom.fr>
In-Reply-To: <CACmP8UJ+Mp_53e9cnKDV3st+3_H_nYW3qkfvib34BS_s+5UPng@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 88.183.119.157
References: <20250629120301.1702897-1-ariel.otilibili-anieli@eurecom.fr> <20250629120301.1702897-2-ariel.otilibili-anieli@eurecom.fr> <CACmP8UJ+Mp_53e9cnKDV3st+3_H_nYW3qkfvib34BS_s+5UPng@mail.gmail.com>
Date: Mon, 30 Jun 2025 01:16:16 +0200
Cc: linux-security-module@vger.kernel.org, "Serge Hallyn" <serge@hallyn.com>
To: =?utf-8?q?Andrew_G=2E_Morgan?= <morgan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1fc1c9-6861c980-481-b1921f0@230729131>
Subject: =?utf-8?q?Re=3A?= [PATCH 1/1] =?utf-8?q?uapi=3A?= fix broken link in 
 =?utf-8?q?linux/capability=2Eh?=
User-Agent: SOGoMail 5.12.1
Content-Transfer-Encoding: quoted-printable

On Sunday, June 29, 2025 16:27 CEST, "Andrew G. Morgan" <morgan@kernel.=
org> wrote:

> Thanks for noticing that!

Your welcome, Andrew!
>=20
> Acked-by: Andrew G. Morgan <morgan@kernel.org>

Much appreciated,
Ariel
>=20
> Cheers
>=20
> Andrew
>

