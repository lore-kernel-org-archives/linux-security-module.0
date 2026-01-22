Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881D92E0413
	for <linux-security-module@vger.kernel.org>; Thu, 22 Jan 2026 08:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769070268; cv=none; b=AGw/+0QrjzaaG+7frVF3TOIb8Qw+K037sC0YY7Y7K3K5YLMHB0Mm9pmtti7a4Dg1/5DuTkjxs1tP3xR4qmGSqL4CfokL6Ls8jvfmAYu0op9jGNChJbhM3n9q1skqWFTDFknsiW+RuUWkc7tYiI2BJnAL7iRf0iuaEXJXMVkkyqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769070268; c=relaxed/simple;
	bh=DiTutNirX4RvIWPEBcfDzYAqoKEhxeIszskS8Lw4n8c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kYPE6YEnuyeX/eVEhhKd+IjaCJEGHxam9DNpiJa8KZzGa9UyFk/eJwOmV90cLVpQs35TxdwBZcdZqxdPyEmT9Y00dYlPsQW1lUqe3gI5cAQOalFfxo8NLoUmvOsTxGYQvael8blkMjfa0xvfNlssbEedlcZZebS+sdJ/l/oIy1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 60M8ONLa081376;
	Thu, 22 Jan 2026 17:24:23 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 60M8OMNw081373
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 22 Jan 2026 17:24:22 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <287edf7f-85fb-46c3-9c70-c8ec7014a0db@I-love.SAKURA.ne.jp>
Date: Thu, 22 Jan 2026 17:24:22 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xfrm: force flush upon NETDEV_UNREGISTER event
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Aviad Yehezkel <aviadye@mellnaox.com>, Aviv Heller <avivh@mellanox.com>,
        Boris Pismenny <borisp@mellanox.com>,
        "David S. Miller"
 <davem@davemloft.net>,
        Florian Westphal <fw@strlen.de>, Guy Shapiro <guysh@mellanox.com>,
        Ilan Tayari <ilant@mellanox.com>,
        Kristian Evensen <kristian.evensen@gmail.com>,
        Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
        Raed Salem <raeds@mellanox.com>, Raed Salem <raeds@nvidia.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Yossi Kuperman <yossiku@mellanox.com>
Cc: Network Development <netdev@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
References: <924f9cf5-599a-48f0-b1e3-94cd971965b0@I-love.SAKURA.ne.jp>
 <537343f7-c580-43b0-9ad2-691701b9fb8e@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <537343f7-c580-43b0-9ad2-691701b9fb8e@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav402.rs.sakura.ne.jp
X-Virus-Status: clean

A debug patch in linux-next-20260121
( https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit?id=fc0f090e41e652d158f946c616cdd82baed3c8f4 )
has demonstrated that calling xfrm_dev_state_flush()/xfrm_dev_policy_flush()
when (dev->features & NETIF_F_HW_ESP) == 0 helps releasing "struct net_device" refcount.

  unregister_netdevice: waiting for netdevsim0 to become free. Usage count = 2
  ref_tracker: netdev@ffff88805d3c0628 has 1/1 users at
       xfrm_dev_state_add+0x6f4/0xc40 net/xfrm/xfrm_device.c:316
       xfrm_state_construct net/xfrm/xfrm_user.c:986 [inline]
       xfrm_add_sa+0x34ca/0x4230 net/xfrm/xfrm_user.c:1022
       xfrm_user_rcv_msg+0x746/0xb20 net/xfrm/xfrm_user.c:3507
       netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
       xfrm_netlink_rcv+0x79/0x90 net/xfrm/xfrm_user.c:3529
       netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
       netlink_unicast+0x80f/0x9b0 net/netlink/af_netlink.c:1344
       netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894
       sock_sendmsg_nosec+0x18f/0x1d0 net/socket.c:737
       __sock_sendmsg net/socket.c:752 [inline]
       ____sys_sendmsg+0x589/0x8c0 net/socket.c:2610
       ___sys_sendmsg+0x2a5/0x360 net/socket.c:2664
       __sys_sendmsg net/socket.c:2696 [inline]
       __do_sys_sendmsg net/socket.c:2701 [inline]
       __se_sys_sendmsg net/socket.c:2699 [inline]
       __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2699
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f
  
  infiniband: balance for netdevsim0@ib_gid_table_entry is 0
  ***** Releasing 1 refcount on 0000000000000000
  ***** Refcount for netdevsim0 changed from 2 to 1

The bond_master_netdev_event(NETDEV_UNREGISTER) case is already calling
xfrm_dev_state_flush() without checking (dev->features & NETIF_F_HW_ESP) != 0.
Therefore, I assume that (dev->features & NETIF_F_HW_ESP) != 0 check in
xfrm_dev_down() is wrong, and I would like to propose

 static int xfrm_dev_down(struct net_device *dev)
 {
- 	if (dev->features & NETIF_F_HW_ESP) {
-		xfrm_dev_state_flush(dev_net(dev), dev, true);
-		xfrm_dev_policy_flush(dev_net(dev), dev, true);
- 	}
+	xfrm_dev_state_flush(dev_net(dev), dev, true);
+	xfrm_dev_policy_flush(dev_net(dev), dev, true);
 
 	return NOTIFY_DONE;
 }

change as a fix for "unregister_netdevice: waiting for netdevsim0 to become free. Usage count = 2"
problem.



But I have a question regarding security_xfrm_state_delete()/security_xfrm_policy_delete().

xfrm_dev_state_flush_secctx_check() calls security_xfrm_state_delete() which can make
xfrm_dev_state_flush() no-op by returning an error value.
xfrm_dev_policy_flush_secctx_check() calls security_xfrm_policy_delete() which can make
xfrm_dev_policy_flush() no-op by returning an error value.

Since xfrm_dev_state_flush()/xfrm_dev_policy_flush() are called by NETDEV_UNREGISTER
event (which is a signal for releasing all resources that prevent "struct net_device"
references from dropping), making xfrm_dev_state_flush()/xfrm_dev_policy_flush() no-op (by
allowing security_xfrm_state_delete()/security_xfrm_policy_delete() to return an error) is
a denial-of-service bug.

Therefore, I wonder what are security_xfrm_state_delete() and security_xfrm_policy_delete()
for. Can I kill xfrm_dev_state_flush_secctx_check() and xfrm_dev_policy_flush_secctx_check() ?

