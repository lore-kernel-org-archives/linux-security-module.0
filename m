Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454DF7710E;
	Fri, 16 Aug 2024 16:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723824635; cv=none; b=og+dEIjcbKvsVlAzj+QW+10owrsgmO049Rp46SIJquexJYm7+qo6cQysbYKNjp8KSFzFtW7iGlvjPqrYMC+1ACLTeId/MCF2gvCt33kFPiOPSSLZJlnSvbUITsQ0u0o4JddCMJyB6f1bng9V6UqMNmU5+l0ZMsn6eLI2/FvQp/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723824635; c=relaxed/simple;
	bh=PAbZgj1z4Bp+T9xpNcj3M7zHP4u7ZGos6dyO6TwEBTk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hbBa0PzdpNtiKm3/h7iAouvJ084+CayT686FrMMIbRlf37vUJGMY2GA5PAFXwYlrcIxzUV6D7LdcNByS+Qa3uCKUUcMWvbOTSUHkHAPyh2XfGrXf9j7dYrRE0IO4c8QzsK2Kt7ESRMS4gO9BMrk364/uVD55WuQxCZErw+kB4FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=dxxA5BNK; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="dxxA5BNK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1723824604; x=1724429404; i=spasswolf@web.de;
	bh=AmchI/mG/89rB0ctm/Lc5xogMtZgADTp8F1OlxCErWc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dxxA5BNKt5E5dGXUu/1mShVE24nJUcfB78loaTD872vuFvtgyz1RKXh5gGQ+rXLe
	 6/jIMEbGg7qrdkxNW2GOrzcFgnO2XadlpkOPb/yMGugpY0siNzA0fJz/0hWgMnzFo
	 NAhqRBhN0dBPrtGJDOaU+ORNGMGYcqwGUer5HcwDY76cBhtuSbDz0D18WAwPCO2nd
	 n3OCNvgWxKElISQzNYPqN/RcSoKJE2PotgKGJzAN/ihnS1PIt7UOW0dIa+pgs6pHB
	 Tscg0WkYEkYiGXtl8nTaL/Hn+Ram82RnyLcRB5X8a28FdhfyOA0NvUeOtThSA1lo9
	 UcK2W7OR6vCGd+VByA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([84.119.92.193]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MCol0-1sW9q012sC-008eIT; Fri, 16 Aug 2024 18:10:04 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: "Liam R . Howlett" <Liam.Howlett@oracle.com>
Cc: Bert Karwatzki <spasswolf@web.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	sidhartha.kumar@oracle.com,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Jiri Olsa <olsajiri@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	Jeff Xu <jeffxu@chromium.org>,
	"Liam R . Howlett" <Liam.Howlett@Oracle.com>,
	linux-security-module@vger.kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: [PATCH v5.1 16/19] mm/mmap: Use vms accounted pages in mmap_region()
Date: Fri, 16 Aug 2024 18:09:59 +0200
Message-ID: <20240816161000.2805-1-spasswolf@web.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JGM+UFz9mnK+dk5IHlGfFo+pKmuhMOGrj45PRVD26wBmNPDV41E
 lK47NqDqgqByTLZbGjYLjaYF+HFeVqqH/jmbrgXKSwbT8tLJn2FGSghTWWgW9LWw56x/gGU
 NNerZhrasjoetmqnt1SJQaXnvW5iyvlwe0Xodks8udK7iOARL+PrfoXpZNb3pDsiOf4cB+z
 fRtx6+prJocut62CHYCcQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rRzJMlqlChs=;NhoU0uBcvC7hw644J1GISkdkjoa
 UIvvOWBiilyu7LnRug6QLpm/RgZ/hH+yerngyKY0lGQgc0y4nGLLIveat4s8TFN7BsQ8IKXfv
 3xSVBIbpET/rHH2OC1V42Og6SN/2YMwkUswzPPSk8YJqbd+au4igW1UP2ygvcs4Fdp3Rw/0kv
 eAPCU0zQR8qvGZuB12l61QtciYO+bWnndY6TS2beIRbjHKS0N0GksyA+EgY6/iDYDIMrq+5SA
 91xMW26mQjg2SjGhH9aXZ6/Xty8G6/woRKj1pzl6gtqsw5YBwQshxYrO6cfhZXo7DgIVdiYsN
 El4T8+HK61YDFDeyqyMohwjboLa/WOYcBV6Qu1opAiTdSiqp/3KyEbEu/pQOL2fvDPo5vNOTO
 2Nj9TAfp0n5KmCjp/Jt6JjZ3ualApxvhz574v7J3aL60m1rwXQA5+7uScdpC9iGyc7yBrqCok
 2uRSWVzPFiWb71knOWLJeL4OYEWALEZXP0fr749sRLq1KsAxPvJmFE1DCd2ZnPfimo9wZGn5Y
 MPkdNRtfQVvXm/b9t7BljR2JiC3yhZtuxQ3442Memu7bs2qgfQdOmHPsrAUKnUFtn7VFO+8Lt
 jCtt7NI7PjcRvWrSX+dIC7IUWtlQMKbzU7jr01p6w6gq/K+dSnbFWmGFbAck4yepCoRh6Yd4p
 Ouw1oIGQBNfYGqRkYdCWr4KrhOCHolJ9/eb2YsCe65AykVfO6382Rs4lQ+L4zxg/VMcN0clIZ
 qv6d9VValj2uGFeOds1AHlMXKY347kOABfeYVn0niwcP1QKnZMJGSfHhQwyQDXL0t/YSKhR0k
 V6pM+pZVK52KQ4GGjJq+uD3A==

Change from nr_pages variable to vms.nr_accounted for the charged pages
calculation.  This is necessary for a future patch.

This also avoids checking security_vm_enough_memory_mm() if the amount
of memory won't change.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Kees Cook <kees@kernel.org>
Cc: linux-security-module@vger.kernel.org
Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
=2D--
 mm/mmap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 57fb1c82a852..d0942b1a62f0 100644
=2D-- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1416,9 +1416,10 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
 	 */
 	if (accountable_mapping(file, vm_flags)) {
 		charged =3D pglen;
-		charged -=3D nr_accounted;
-		if (security_vm_enough_memory_mm(mm, charged))
+		charged -=3D vms.nr_accounted;
+		if (charged && security_vm_enough_memory_mm(mm, charged))
 			goto abort_munmap;
+
 		vms.nr_accounted =3D 0;
 		vm_flags |=3D VM_ACCOUNT;
 	}
=2D-
2.45.2

