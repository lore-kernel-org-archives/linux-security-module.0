Received: from smtp.eurecom.fr (smtp.eurecom.fr [193.55.113.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F3625523C
	for <linux-security-module@vger.kernel.org>; Wed,  2 Jul 2025 10:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.55.113.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751450741; cv=none; b=YUseW058B8GUIq/ulFWfJ19NKjx0RthbQa4MKzAHbbW3G+Fnt8bNZHm8C2IjfYaeJvhlyMNEoonu/Q6Yic36HEmBBeD4zNbneAiULI8pLZ+f5R/a3iEOyzVBxevhx6+OvVlv4g8ZAR5AtoW9Yik6CnP+A0N//XCo8Pl1X5TRmH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751450741; c=relaxed/simple;
	bh=TANlYEVy2eQZaE/Y9PImX5kasoWVxm5mFUMWzwOi2bY=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=LPu1qQOf8wv2aMtV9MjSR2w0dv3bQyoXEPy58TofRqaQvfdwMybO2+zEOXdA0FIgjCeGxFha13YKmNi8xcnxqJuKlQ6ZoJCIvWe080w2qOplB9S/m8IXEUQ2JvnZd7u/ABYCnWp78+XGZKq2ofrs0zdWnU7wNkrhUwwT6l4SrL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr; spf=pass smtp.mailfrom=eurecom.fr; dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b=LkY24fyd; arc=none smtp.client-ip=193.55.113.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eurecom.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b="LkY24fyd"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
  t=1751450739; x=1782986739;
  h=from:in-reply-to:references:date:cc:to:mime-version:
   message-id:subject:content-transfer-encoding;
  bh=TANlYEVy2eQZaE/Y9PImX5kasoWVxm5mFUMWzwOi2bY=;
  b=LkY24fydEIyi94UsXblBW+aMKEM35pHcUo634/fqGjyC9inwsCLuz1Wi
   Alqk2wXTVeeAyUUNsIZXr9Ji5l7C/y8lt39R95GZfTsANbbtg0+qUbPHN
   3jEGtYhb1JRdrbCu3PNX6PRLaiL65ZfNy4eJAZjcu1hph98lGUXaKjkBb
   o=;
X-CSE-ConnectionGUID: dqiHu/DQTF2bFnMqLL3ZfQ==
X-CSE-MsgGUID: e5/LHzg3SG2TIb/Suk+2jA==
X-IronPort-AV: E=Sophos;i="6.16,281,1744063200"; 
   d="scan'208";a="2012218"
Received: from quovadis.eurecom.fr ([10.3.2.233])
  by drago1i.eurecom.fr with ESMTP; 02 Jul 2025 12:05:37 +0200
From: "Ariel Otilibili-Anieli" <Ariel.Otilibili-Anieli@eurecom.fr>
In-Reply-To: <aGSXgF797s+Oz4C5@mail.hallyn.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 88.183.119.157
References: <20250629120301.1702897-2-ariel.otilibili-anieli@eurecom.fr>
 <66376202561209641dad1c8894ec62cb@paul-moore.com> <aGSXgF797s+Oz4C5@mail.hallyn.com>
Date: Wed, 02 Jul 2025 12:05:36 +0200
Cc: "Paul Moore" <paul@paul-moore.com>, linux-security-module@vger.kernel.org, =?utf-8?q?Andrew_G_=2E_Morgan?= <morgan@kernel.org>
To: =?utf-8?q?Serge_E=2E_Hallyn?= <serge@hallyn.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1ad13b-68650480-81f-51fddb80@179270172>
Subject: =?utf-8?q?Re=3A?= [PATCH 1/1] =?utf-8?q?uapi=3A?= fix broken link in 
 =?utf-8?q?linux/capability=2Eh?=
User-Agent: SOGoMail 5.12.1
Content-Transfer-Encoding: quoted-printable

Hi Serge, hi Paul,

On Wednesday, July 02, 2025 04:20 CEST, "Serge E. Hallyn" <serge@hallyn=
.com> wrote:

> On Tue, Jul 01, 2025 at 10:05:45PM -0400, Paul Moore wrote:
> > On Jun 29, 2025 Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>=
 wrote:
> > > Signed-off-by: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr=
>
> > > Acked-by: Andrew G. Morgan <morgan@kernel.org>
> >=20
> > My personal preference would be for a commit description that doesn=
't
> > wrap when running 'git log' on a 80 char wide terminal, but ultimat=
ely
>=20
> Agreed.  Would you mind updating that, and then I'll pull it in?

Sure, there you are: https://lore.kernel.org/all/20250702100021.1849243=
-2-ariel.otilibili-anieli@eurecom.fr/
>=20
> thanks,
> -serge
>=20
> > that is Serge's call to make.  Otherwise, the updated URL looks goo=
d to
> > me.
> >=20
> > Reviewed-by: Paul Moore <paul@paul-moore.com>

Thanks for your feedback,
Ariel

