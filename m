From: ztong@vt.edu (TongZhang)
Date: Tue, 25 Sep 2018 19:36:25 -0400
Subject: Leaking path or inconsistency LSM checking observed in fs/net
In-Reply-To: <e6ef53a8-187e-d030-9246-3de2a9a79265@tycho.nsa.gov>
References: <8004D467-2F24-4E9F-A429-AA4EE5D2E366@vt.edu>
	<e6ef53a8-187e-d030-9246-3de2a9a79265@tycho.nsa.gov>
Message-ID: <14C343F1-CCB8-4B2D-AB68-653300E64CB0@vt.edu>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

ocfs2 is using sock_create instead of sock_create_kern in kernel v4.18.5.

fs/ocfs2/cluster/tcp.c: 1636
https://elixir.bootlin.com/linux/v4.18.5/source/fs/ocfs2/cluster/tcp.c#L1636
>ret = sock_create(PF_INET, SOCK_STREAM, IPPROTO_TCP, &sock);

fs/ocfs2/cluster/tcp.c: 2035
https://elixir.bootlin.com/linux/v4.18.5/source/fs/ocfs2/cluster/tcp.c#L2035
>ret = sock_create(PF_INET, SOCK_STREAM, IPPROTO_TCP, &sock);


> On Sep 25, 2018, at 2:44 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> On 09/25/2018 01:27 PM, Tong Zhang wrote:
>> Kernel Version: 4.18.5
>> Problem Description:
>> We found several leaking path or inconsistency LSM design issue in fs/net.
>> Currently we can only observe sock creation from kernel and all bind/listen/connect are not sent to LSM.
>> So, we think that those net/socket related stuff should all go through LSM check and being audited
>> even it is not a user thread or process.
>> Here?s an example where we have a check:
>> in fs/ocfs2/cluster/tcp.c:2035 o2net_open_listening_sock() a sock is created using sock_create(),
>> where a LSM check security_socket_create is called(net/socket.c:1242)
>> And where we don?t have a check
>> fs/ocfs2/cluster/tcp.c:2052 bind
>> fs/ocfs2/cluster/tcp.c:2059 listen
>> fs/dlm/lowcomms.c:1264 bind
>> fs/dlm/lowcomms.c:1278 listen
>> fs/dlm/lowcomms.c:1354 listen
>> several places that use kernel_bind/kernel_listen/kernel_connect
>> net/socket.c:3231 kernel_bind
>> net/socket.c:3237 kernel_listen
>> net/socket.c:3286 kernel_connect
> 
> That's intentional.  LSM isn't trying to mediate kernel-internal operations, and we do not want to apply permission checks against the credentials of the current userspace process for such operations.  ocfs2 should likely be using sock_create_kern.
> 
