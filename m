Received: from cstnet.cn (smtp20.cstnet.cn [159.226.251.20])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9961FDA;
	Fri, 21 Nov 2025 01:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763686909; cv=none; b=PByn0MrIfim5VtRXIVflksBDZ5bVdMPL32xzPEBygT7q22PSweryiL6+k0J+3mVlJ4++25Wj/ApEFoQMgVdxREnR8+n5IpBHgMribNCfnRgx6LehgjreXlOHrojVUxawb2bgEcmd7BVDol5N8DctBxQSpG+gOzGrf32lvLnFCAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763686909; c=relaxed/simple;
	bh=N2cD6bNXIvl0+doAV9misiGXEWkLKzBOdju+Bg3vydQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=ZrCaNbqn+qpS4xyyva1ta/KoqLN/BWMiPGJKCyIr6js5j4KGvkCN1x8T0JWOKtG+bPxldiK3L4HTiAcBdoO1zNiOOIicM1fq3z3eNPHozdXXQK9P0nMYKcmQ70nRJ4FtBZMiaPCWTwowf6MOIAzHV3s/GgffHERo/0uvVC7qpkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn; spf=pass smtp.mailfrom=mails.ucas.ac.cn; arc=none smtp.client-ip=159.226.251.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.ucas.ac.cn
Received: from xujiakai24$mails.ucas.ac.cn ( [210.73.43.101] ) by
 ajax-webmail-APP-10 (Coremail) ; Fri, 21 Nov 2025 09:01:38 +0800
 (GMT+08:00)
Date: Fri, 21 Nov 2025 09:01:38 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?6K645L2z5Yev?= <xujiakai24@mails.ucas.ac.cn>
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: Re: [BUG] landlock: sleeping function called from invalid
 context in hook_sb_delete()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.1-cmXT5 build
 20240627(e6c6db66) Copyright (c) 2002-2025 www.mailtech.cn cnic.cn
In-Reply-To: <20251120.hoT5ye5thooR@digikod.net>
References: <20dd8187.9d18.19a75eadc43.Coremail.xujiakai24@mails.ucas.ac.cn>
 <20251120.c5c17c664315@gnoack.org> <20251120.hoT5ye5thooR@digikod.net>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <4b330023.22e53.19aa3ee5b4a.Coremail.xujiakai24@mails.ucas.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:tACowADnz+fyuR9p7XUDAA--.29076W
X-CM-SenderInfo: 50xmxthndljko6pdxz3voxutnvoduhdfq/1tbiBg0ME2ke2qXrWgA
	Csv
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW5Jw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGVsbG8gTWlja2HDq2wsCgpUaGFua3MgYSBsb3QgZm9yIHlvdXIgcmVwbHkuCgpCZXN0IHJlZ2Fy
ZHMsCi1KaWFrYWk=
