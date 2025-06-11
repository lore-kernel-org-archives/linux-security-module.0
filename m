Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35681DE2A4
	for <linux-security-module@vger.kernel.org>; Wed, 11 Jun 2025 16:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749660315; cv=none; b=FsC2wW7avhVqXWgee9ymVpiNN1CZ7ZKPR5UHdJ2vI/Yl+spOHBuDqLjtyc22c9oX7m38XoiRd+ZDHrJFfsr65NwvDeeRbwDaLJMbL+Zp5l2DMyhK4TcyRMMt+V7P2dn3D4+WMGw+T+TtV6icJc2kypBGB0Q8ZroVt8V2Wv3Iy7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749660315; c=relaxed/simple;
	bh=GpsmAPZBVSJJ+9ubBo2hDGtPMH3NzHnys3NejUG7amc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ePwvJzZxxJVGE3V1WXqaqT18+fwf6kUZFgr13HO/N/+q9YPkzu6EDEaZDu8BAzQ//qz1vZAbHOB7INU+vJ14ydZtcUCY5QdYCoA49qinmTv3zftUeIDM4EJfQ9gAtR17J9Q3jZyZwi+B17fmyMZNvoXURE6PBE2WbGwwlVWMrRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WeXA8I0r; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WeXA8I0r"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e81ec95d944so1048891276.1
        for <linux-security-module@vger.kernel.org>; Wed, 11 Jun 2025 09:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1749660312; x=1750265112; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VjFLPJSCK7nqLjUFHebJGCzVS7403d3JF/BF7G+jz7k=;
        b=WeXA8I0rJdCnKfArMTXJ/XnY9sMyl7dyuD3RJJzQEq8P5Ns/7c/erFgeDYHU0zu1Rx
         goNLdT7BoW49m3a4Gz59SWIr80FeL058ysHXZmhg100ohMqjJe9/iCkIlE/DhNap+Cx9
         cYyd1Gxg2TcTiXc4rf5iInBzrsEiYtkeuDGMz919WlUGkvjc66NscX802gw7FY8HmO/k
         FMfet5ck0LzXAVWejyLdeWe0Cd2J0Ypase7AVnWlVL8txCUZ3wLvDtRv2bjIpieBq6v2
         a9umDNJt82X+AhbhtUg2vd1cWHF2MfE5VA0rP2eERl1OLt/7P+uX+8fPIZvxVD28Y9cT
         xACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749660312; x=1750265112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VjFLPJSCK7nqLjUFHebJGCzVS7403d3JF/BF7G+jz7k=;
        b=OO6h1f4dlLX6qjhKOvFx4w7AYbt1M2hUT0DcM80H978zEA6eAKoMhRyPETaTrgKQnE
         Bau574wPHRn1Rif8EV0ARxmiHkc1FcZNE3gNkuHwCTKc9a9MmPOI0uYLb+M8gXWs6ABY
         CtYFnyNYGPXrRlj61Da2sSRDX46RBtyk06P2XWeQyWI7StBVjG9pMLYSYGXZ0pA4uLSB
         RlXCfjGs8ISWM+T7q/BzAAs0HWVYnLXUxjK96KdB2vAu1mII7zHoEGFmYkRKSjXdao3k
         5Qwj9MyN/Ex3zT4jcChmyITNj0wOTbPQNcB4OWT5SPmfaVRlvTQ2hqMYRx+GXr6pvuQv
         aL2A==
X-Gm-Message-State: AOJu0YwiegbDBacbEaKkppcoWyyaT0xf2plzF/wKEQd6UF+ecA0UO2ka
	+t7XbxZ5CREA7j6I2G7Cst+1ogzjsVyH6rByjYvBT9hVqScEy0VtwJsfN12FDtsg6wacdK/Fw6u
	3D35Ah3QqSZg3HhiHeQ7wVu0C714m+RPG5vTMJs5RDpH8hTkLxMM=
X-Gm-Gg: ASbGncsZVeRsOicNzn12/HCbZXypluMBYqf+Qqxm2BMnzUJz7dwG6RpkHV+hQ+fU3Ct
	1p9tNT+y+8yQmwkNUk+pG5adkMre42pI/mSxnIpcTVoLcmfIAQ3GJIzrP3cHeKp2JHyRNQ23lTS
	IcQAUv/Lj0Zaop6L1ROPxUpNqjx0TrYqhX8wedXTis1mk=
X-Google-Smtp-Source: AGHT+IFpVzU5xakUGIWEFzt3Vs31IfWYUQtu2lGuLXxdGa+vrXBOhii19UeY+k9qsztms/Ib9g7qayNwgfku7adO1V4=
X-Received: by 2002:a05:6902:1145:b0:e81:cf4a:a1ef with SMTP id
 3f1490d57ef6-e820ba2af86mr154468276.10.1749660311765; Wed, 11 Jun 2025
 09:45:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 11 Jun 2025 12:45:00 -0400
X-Gm-Features: AX0GCFsd637Kjp2pdqdIqT1H0upvh65nnom8p7jd4vEpZpByetyp6Zkn9cfa1z0
Message-ID: <CAHC9VhS9P-fgWac_sJ_dq6_AQf76RGiqLAmOFnR_4NZ83KQogw@mail.gmail.com>
Subject: ANN: LSM and SELinux trees to rebase to v6.16-rc2 next week
To: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

In order to pickup an xattr fix, link below, in the LSM and SELinux
trees, I'll be rebasing the lsm/dev and selinux/dev trees next week
once v6.16-rc2 is released.  Currently each tree only has one trivial
patch in their respective dev branches so the rebase is expected to be
trivial.

-- 
paul-moore.com
