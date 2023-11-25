Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="C7fevQaK"
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFB9F3
	for <linux-security-module@vger.kernel.org>; Sat, 25 Nov 2023 06:47:26 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-daf4f0e3a0fso2600101276.1
        for <linux-security-module@vger.kernel.org>; Sat, 25 Nov 2023 06:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700923645; x=1701528445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MbBDsUYFRBbpaPGcvLn4ZOnFdI0AYXZ3B/wevF5TUtg=;
        b=C7fevQaKpfPHGnPqXI6umr9h8FIA2PwoLCLMhZ0keu6Zd9i1n+Pmw1gz9F9QB8Nu1S
         S2ozkK3ozg1Wlv2yqslIOCPPYu+JZaL7O0gNmJ9bZErzJmwQFHy3fbEZi999H4Cwn9+0
         z/Bdz2KveDUeVtLEV8yXqQgeq+b8YROpjStqpQGy5h+0MfX38M8hqh8vKto4afKXAFxl
         8wKVpNFTAUViVGb4t2lRUhl8OsWv9PNIJ3DkCjfByYQgiWNQwzYaXqMPAmcNvSEljNWk
         nTz5HI5LcumNFtPgU3OTs0m2bKUiuItSHrgcPZLOg5TN/lF5ayaKAonocL5aaBWdVwil
         Aiow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700923645; x=1701528445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MbBDsUYFRBbpaPGcvLn4ZOnFdI0AYXZ3B/wevF5TUtg=;
        b=Wvw2gsKuuJLwKmAh1qDePS/RMMaFFa5nwNkLQukIP/eSjaU0mSOsb2n0VHVE8zXXth
         so03cBneNk9v9//hVKhG/KgywsHhKQPe3ZrTyPMv2sJZs26yqn9oA6jRpRg3gXqVDEzX
         YvXg2/BcVZznaea+WXWquqsjhBM+gUhBx3BCAqqW5pJUOHk0Lq7YFkWt64rwjNROxJPK
         A44WKm2YzZUYhyI9EkIrsbwoJOuvVCXxC7QgM5B8LMCA61yDBuM8Sw+zvkaB47gzV7Iw
         rPSE1FQPGLuCXeq1iPFZkomrAKpPetDXU/4z/xSJssFYNVGGtLhL8Hc2CPwp++R0mQyC
         XdRQ==
X-Gm-Message-State: AOJu0YzPVympGOd2BarE8rID1BTGypchhFzhL4DzwOfUg4Qc0J3CPe4z
	2QG1WBo6q3/RKbp7D9xwPOC7Pj9RTRRYr4jW4+ao
X-Google-Smtp-Source: AGHT+IEdYo7torc3WD8zzpy2vPVUODcvVvdvOHPOf8VVQ1q+Lx6kGrInycI6vKwkUYmT5ZwmLxh62dX5f0eEi7ztDnA=
X-Received: by 2002:a25:bf8b:0:b0:daf:76da:fe2b with SMTP id
 l11-20020a25bf8b000000b00daf76dafe2bmr5842914ybk.10.1700923645597; Sat, 25
 Nov 2023 06:47:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231123092314.91299-1-Ilia.Gavrilov@infotecs.ru>
In-Reply-To: <20231123092314.91299-1-Ilia.Gavrilov@infotecs.ru>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 25 Nov 2023 09:47:14 -0500
Message-ID: <CAHC9VhQGX_22WTdZG4+K8WYQK-G21j8NM9Wy0TodgPAZk57TCQ@mail.gmail.com>
Subject: Re: [PATCH net v2] calipso: Fix memory leak in netlbl_calipso_add_pass()
To: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Huw Davies <huw@codeweavers.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 4:25=E2=80=AFAM Gavrilov Ilia <Ilia.Gavrilov@infote=
cs.ru> wrote:
>
> If IPv6 support is disabled at boot (ipv6.disable=3D1),
> the calipso_init() -> netlbl_calipso_ops_register() function isn't called=
,
> and the netlbl_calipso_ops_get() function always returns NULL.
> In this case, the netlbl_calipso_add_pass() function allocates memory
> for the doi_def variable but doesn't free it with the calipso_doi_free().
>
> BUG: memory leak
> unreferenced object 0xffff888011d68180 (size 64):
>   comm "syz-executor.1", pid 10746, jiffies 4295410986 (age 17.928s)
>   hex dump (first 32 bytes):
>     00 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000730d8770>] kmalloc include/linux/slab.h:552 [inline]
>     [<00000000730d8770>] netlbl_calipso_add_pass net/netlabel/netlabel_ca=
lipso.c:76 [inline]
>     [<00000000730d8770>] netlbl_calipso_add+0x22e/0x4f0 net/netlabel/netl=
abel_calipso.c:111
>     [<0000000002e662c0>] genl_family_rcv_msg_doit+0x22f/0x330 net/netlink=
/genetlink.c:739
>     [<00000000a08d6d74>] genl_family_rcv_msg net/netlink/genetlink.c:783 =
[inline]
>     [<00000000a08d6d74>] genl_rcv_msg+0x341/0x5a0 net/netlink/genetlink.c=
:800
>     [<0000000098399a97>] netlink_rcv_skb+0x14d/0x440 net/netlink/af_netli=
nk.c:2515
>     [<00000000ff7db83b>] genl_rcv+0x29/0x40 net/netlink/genetlink.c:811
>     [<000000000cf53b8c>] netlink_unicast_kernel net/netlink/af_netlink.c:=
1313 [inline]
>     [<000000000cf53b8c>] netlink_unicast+0x54b/0x800 net/netlink/af_netli=
nk.c:1339
>     [<00000000d78cd38b>] netlink_sendmsg+0x90a/0xdf0 net/netlink/af_netli=
nk.c:1934
>     [<000000008328a57f>] sock_sendmsg_nosec net/socket.c:651 [inline]
>     [<000000008328a57f>] sock_sendmsg+0x157/0x190 net/socket.c:671
>     [<000000007b65a1b5>] ____sys_sendmsg+0x712/0x870 net/socket.c:2342
>     [<0000000083da800e>] ___sys_sendmsg+0xf8/0x170 net/socket.c:2396
>     [<000000004a9b827f>] __sys_sendmsg+0xea/0x1b0 net/socket.c:2429
>     [<0000000061b64d3a>] do_syscall_64+0x30/0x40 arch/x86/entry/common.c:=
46
>     [<00000000a1265347>] entry_SYSCALL_64_after_hwframe+0x61/0xc6
>
> Found by InfoTeCS on behalf of Linux Verification Center
> (linuxtesting.org) with Syzkaller
>
> Fixes: cb72d38211ea ("netlabel: Initial support for the CALIPSO netlink p=
rotocol.")
> Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
> ---
> v2:
>   - return the error code in netlbl_calipso_add() if the variable calipso=
_hops is NULL
> v1: https://lore.kernel.org/all/20231122135242.2779058-1-Ilia.Gavrilov@in=
fotecs.ru/
>
>  net/netlabel/netlabel_calipso.c | 49 +++++++++++++++++----------------
>  1 file changed, 26 insertions(+), 23 deletions(-)

This looks good to me, thanks!

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
