Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794756034;
	b=jVhd1RTnRfMyuEv+65va5Pqz4qIdijTAOp91CccKSbEMG92z3uvXVcO3nuADkW4IavIK
	 xIryCDSPHje5i990jFJVg/5fSIRec0++jBfz3q9OW/FI77JwGgDGFwEQQa7bbuO6gqIeh
	 qegiuwNBgSdxUNMYuGfRu/D2xbvd/kR56f/btjcka6cbs/Dj2EElOearwHR/p6LgqfadZ
	 0RGC4G1elUz+CNKQlqmV0q0vrLzDG6sH8gd80A0CKOYNOtEFLsQvbJk727qM1hDk5DFlR
	 bjW0iN6ttiYwxVjUE581TxiGFpjz+m0tbkBxm+yKjieNYB83nMPWdY3MhEM/lNafESg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794756034;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ai8EBrIICvkd1TZSYYlXYZrQb4Tl1iyP+eNEDVZe44Y=;
	b=lpSMbXOxLCmuDg6ENTtvLj8N7Kc+LjW8RMTVDEYWZY/+ZcBUiMU7FplvfPBOQ9pk5vzj
	 M01Kusaj6foKyBn3bN4enLnF7duhBVIj1QvGDXiq/W/V0VA+vDB6PGWqy2w9UXhJLr6Oy
	 5x++TRSx4K4tgp/9Kc2vAQIsRs4ZaaRyCuQ7D1dfI6xDFA7fdgV6wxXb4fWj+RLwMuBPc
	 gFHfqYc/Im3bVQdEHWQ1vVrbnQci3y1ZeKn5MjKd8iHFOUgGzknzJDf5uKKvRG00DQeDt
	 TctI3K+y694grR7hIvRGJOzBHH8BG99q2VJs0zUzs6rbblPn6ajVDrgzdx2Ntr1svgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b="CNL/OqC3";
	arc=none smtp.remote-ip=162.62.57.64
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C14606A31F;
	Sun, 15 Nov 2026 15:20:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26C14606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=CNL/OqC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794756027; bh=ai8EBrIICvkd1TZSYYlXYZrQb4Tl1iyP+eNEDVZe44Y=;
	h=From:To:Cc:Subject:Date;
	b=CNL/OqC3JJ8kwfUFoWwavj7k+SxSwZ07Nw3OhcKE9vjcyBT9lPviPFvLRCrnkvETg
	 FUvYc4EeNURj18CE+aF1zq2W/l+nhasHXTcFatJiaq/40CVeJkno2FvThu+AyrzP48
	 JkPvsPo7FDxxu6+yFBnykL1QDyNOKd+JKeuvFU3w=
Received: from 172-1-1-128.lightspeed.hstntx.sbcglobal.net.localdomain ([163.125.232.4])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 5169F010; Sun, 15 Nov 2026 23:20:22 +0800
X-QQ-mid: xmsmtpt1794756022t3d0f9uoo
Message-ID: <tencent_5E314704B7770A972FCB82AC81BB91A39307@qq.com>
X-QQ-XMAILINFO: NXRI5vttMTiBLU9KSgBO8Uo65ciDfXfLvsMfYaM+hTlxuRZ0PXU3PNVIM7QS2N
	 Du1vZu/BeeMeW2poWvpDJGTr8YVQwQfeNEvvEckTA11SDC1p3t5iT8+s/HZFxMbCxmRhrkHZ01e0
	 kceXFWEPo3WOSnfLvFLdm9Qn8nggkMPCa6U8Ucs1bMcxy/cuL8Z/ffFofjKssOHWV+1hrqN9x5VI
	 3LQoWYShRrF3gzT7b7hStB2nXRuwiimE0av9BTQxmdtw7Fcnh14p15u+M7aO/HN5rAWcFwTiaCJd
	 ZA5uAehOWTmm8fSJvK9GOKUHeEphy8z4rSRJ4heYAhMk8DRIbZc1QE9stJNZd3wGjhM+cyTUA5XD
	 x+lJ3HYcsxCC1dsg9jjuTa+R7MDTW0PIHHO3PC4yDwYe0TRKr4keYut7iSIiKTfrRntuOIySw0Hk
	 I/w9a9Daw/1EiLySLDRkyjxBfq6tZnrA74dQ6qX2wKhJxq9GUsqRyHg+wcIfjrfhtWqoebhRMMpv
	 b9Z24+do5W3HjJmH9u3MLquJUESn1R9gUX9/xs+rJ6bmtn1tyucUPY76wG2ZJFsAMaGccPSMXdj6
	 ew+zosXmgVzWFeYsQju7pMUz/s7SLFQ/c1os+7SJHX8kb80bnDx065hkQi0RcmjbS0kO4/z90Uur
	 AY+Zj+71Erw6ac1mK2z1kJG+sewjIWeTfp1UIGu+WWjkVWItZ//DZbNdKgLfe7jjK+Wotr3xTdhm
	 SK7maDpDZ+p06Xgc6zSYgql3Y0oLPdsws4OtrPF4NQ8Tet98HSDOPwaVxsyQqwmCICENAUJBnV3I
	 0qSiZv4DEeV0ydVSX18voJ9ATw4WyEC4Z0z4p4FgjmjDEuLbxtjXANHa69zP5oUeLmDoh5WPAKIa
	 FSZc2k6ENk2GbdVmUl5vDmxwzu6WNAWJ18epCDhGrscxNfRWlc3bfAoBCNTogxsAzFo+6v/aCX83
	 6btFSO3pyI7EwazY/910m1Ysvk8C65CcfKiiwYwyPYHlJ44Qu1tzsIlmTPYL9z+mmntScbSgGFzI
	 3KvFGq3BBoKW66cVqQi170lVJH/s/je7nDYUOomp+STz3xmRQFFsKXJyU3dzvlXlboVV+Mu4qWps
	 Hf/BmFI4UdMaob9MwGmD59tA5h1wpx34bk+8WYkfs6xuIClVx+hcobgUzY4JrMkl/JY/JA9eYmHz
	 CJ+zNtcKsEr7rS4TpkzgHwQjqH
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Yan Zhu <zhuyan2015@qq.com>
To: alexs@kernel.org,
	si.yanteng@linux.dev,
	corbet@lwn.net,
	mic@digikod.net
Cc: dzm91@hust.edu.cn,
	skhan@linuxfoundation.org,
	gnoack@google.com,
	zhuyan2015@qq.com,
	linux-doc@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH 00/10] docs/zh_CN: add LSM admin-guide Chinese translation
Date: Sun, 15 Nov 2026 23:19:56 +0800
X-OQ-MSGID: <cover.1781105672.git.zhuyan2015@qq.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds the Chinese translation for the Linux Security Module
(LSM) admin-guide documentation, including the main index and all ten
sub-pages: apparmor, LoadPin, SELinux, Smack, tomoyo, Yama, SafeSetID,
ipe, and landlock.  The admin-guide toctree is also updated to list the
newly translated LSM/index.

The original English documentation was restructured into reStructuredText
by Kees Cook in commit 504f231cda56 ("doc: ReSTify and split LSM.txt"),
and each sub-page has been kept up-to-date with subsequent mainline changes.


base: https://git.kernel.org/pub/scm/linux/kernel/git/alexs/linux.git docs-next



Yan Zhu (10):
  docs/zh_CN: add LSM/index Chinese translation
  docs/zh_CN: add LSM/apparmor Chinese translation
  docs/zh_CN: add LSM/LoadPin Chinese translation
  docs/zh_CN: add LSM/SELinux Chinese translation
  docs/zh_CN: add LSM/Smack Chinese translation
  docs/zh_CN: add LSM/tomoyo Chinese translation
  docs/zh_CN: add LSM/Yama Chinese translation
  docs/zh_CN: add LSM/SafeSetID Chinese translation
  docs/zh_CN: add LSM/ipe Chinese translation
  docs/zh_CN: add LSM/landlock Chinese translation

 .../zh_CN/admin-guide/LSM/LoadPin.rst         |  33 +
 .../zh_CN/admin-guide/LSM/SELinux.rst         |  45 ++
 .../zh_CN/admin-guide/LSM/SafeSetID.rst       |  82 ++
 .../zh_CN/admin-guide/LSM/Smack.rst           | 722 +++++++++++++++++
 .../zh_CN/admin-guide/LSM/Yama.rst            |  71 ++
 .../zh_CN/admin-guide/LSM/apparmor.rst        |  59 ++
 .../zh_CN/admin-guide/LSM/index.rst           |  46 ++
 .../zh_CN/admin-guide/LSM/ipe.rst             | 723 ++++++++++++++++++
 .../zh_CN/admin-guide/LSM/landlock.rst        | 169 ++++
 .../zh_CN/admin-guide/LSM/tomoyo.rst          |  63 ++
 .../translations/zh_CN/admin-guide/index.rst  |   3 +-
 11 files changed, 2015 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/translations/zh_CN/admin-guide/LSM/LoadPin.rst
 create mode 100644 Documentation/translations/zh_CN/admin-guide/LSM/SELinux.rst
 create mode 100644 Documentation/translations/zh_CN/admin-guide/LSM/SafeSetID.rst
 create mode 100644 Documentation/translations/zh_CN/admin-guide/LSM/Smack.rst
 create mode 100644 Documentation/translations/zh_CN/admin-guide/LSM/Yama.rst
 create mode 100644 Documentation/translations/zh_CN/admin-guide/LSM/apparmor.rst
 create mode 100644 Documentation/translations/zh_CN/admin-guide/LSM/index.rst
 create mode 100644 Documentation/translations/zh_CN/admin-guide/LSM/ipe.rst
 create mode 100644 Documentation/translations/zh_CN/admin-guide/LSM/landlock.rst
 create mode 100644 Documentation/translations/zh_CN/admin-guide/LSM/tomoyo.rst

-- 
2.43.0

