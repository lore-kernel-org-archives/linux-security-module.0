Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF72322E;
	Fri,  9 May 2025 04:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746765446; cv=none; b=JeB/sHEIp4arIsFawLhTjIJJktM3iBjMHooV4+lgf8KY2DVl2JFuwTZw3JmZ4d2g0hkKc8j80AuVyeD+uvyUChr68fhx8P3p2wipfjVAnofiqNja7X1r0j9F35/EmHZabGfdr+MFovLoU6ve+vqSzPoSLrvYvgX67SAQwizHMWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746765446; c=relaxed/simple;
	bh=Ipe4mV+J9vP7HklIxq6kVTdKpe3daV5fY9cIrl1hQLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=haYGcZZtcVSN0+1ecJAt4Gf1G9V9bUtPj3c9f18DDcgfYKrVYUHApmn/oPlZnrlPhmDN7f8xE8V+dblZYIxgmLIlHihIcsBqqutDCUFJPqWdySsETHx2kgGV47ZoM0UqDYNXFqg8One6NLN7g6H5qatjz49I4rFJwif0SAzDyqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=aYpjwn20; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="aYpjwn20"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uP3s/ajzuYrNI5apkZ3sO7dk9TQmL1y6hyIKvcgbE4g=; b=aYpjwn200vewNojIuJx0oLbGh/
	yX2ZngJLJ/izqqnTcXqdeo5V7KQNkyOVerj77kS9R09Hs7jtP5TLzINnTU/MiJSTEDH4lCXNXo3Kv
	dOtiT4oN0qAEH+LmLjumG+upd6qmQLpq7cjb+F27mswN4G2XIhWKfJ+q+5x2SD7IH8yNQzSOTwhH1
	W9rC6HNUeV8nwvi3SiK579NTtN4WzEW0M9Weo9EuCcfv9oOpMwtZILQ3t7llrX+lE3Mz5IbCd+MOO
	b+k0xev8wzQaeIGcHb1jL5UiE7N0jbdUsYZY2NV5Vl1TZumXP7mSxq5PSDCYGvnHXlSQsryP7qZcf
	CGeKZR4g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDFU0-0000000A70z-3vFd;
	Fri, 09 May 2025 04:37:13 +0000
Date: Fri, 9 May 2025 05:37:12 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: alexjlzheng@gmail.com
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	greg@kroah.com, chrisw@osdl.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: Re: [PATCH v3] securityfs: fix missing of d_delete() in
 securityfs_remove()
Message-ID: <20250509043712.GK2023217@ZenIV>
References: <20250508140438.648533-2-alexjlzheng@tencent.com>
 <20250509032326.GJ2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509032326.GJ2023217@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, May 09, 2025 at 04:23:26AM +0100, Al Viro wrote:

> I have fixes for some of that crap done on top of tree-in-dcache series;
> give me an hour or two and I'll separate those and rebase to mainline...

Completely untested:
git://git.kernel.org:/pub/scm/linux/kernel/git/viro/vfs.git #untested.securityfs

on top of v6.15-rc5.  And I'm serious about the "untested" part - it builds
with allmodconfig, but that's all I've checked.  So treat that as an outline
of what could be done, but don't use as-is without serious testing.
