From: ebiggers3@gmail.com (Eric Biggers)
Date: Mon, 3 Apr 2017 10:59:29 -0700
Subject: [PATCH] KEYS: fix dereferencing NULL payload with nonzero length
In-Reply-To: <3451.1491234402@warthog.procyon.org.uk>
References: <20170401213428.17097-1-ebiggers3@gmail.com>
	<3451.1491234402@warthog.procyon.org.uk>
Message-ID: <20170403175929.GB72831@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Apr 03, 2017 at 04:46:42PM +0100, David Howells wrote:
> Eric Biggers <ebiggers3@gmail.com> wrote:
> 
> > -	if (_payload) {
> > +	if (plen) {
> 
> "if (_payload && plen)" would be better.
> 
> David

No, that doesn't solve the problem.  The problem is that userspace can pass in a
NULL payload with nonzero length, causing the kernel to dereference a NULL
pointer for some key types.  For example:

	add_key("asymmetric", "desc", NULL, 1000, KEY_SPEC_SESSION_KEYRING)

Results in (assuming CONFIG_X509_CERTIFICATE_PARSER=y):

	[    6.046093] BUG: unable to handle kernel NULL pointer dereference at           (null)
	[    6.047781] IP: asn1_ber_decoder+0xe0/0x588
	[    6.048723] PGD 79570067 
	[    6.048726] PUD 7a7d4067 
	[    6.048999] PMD 0 
	[    6.048999] 
	[    6.048999] Oops: 0000 [#1] SMP
	[    6.048999] CPU: 0 PID: 2509 Comm: add_key Not tainted 4.11.0-rc5-ext4-00007-g4ad72555b842-dirty #136
	[    6.048999] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
	[    6.048999] task: ffff88007a664640 task.stack: ffffc90000a20000
	[    6.048999] RIP: 0010:asn1_ber_decoder+0xe0/0x588
	[    6.048999] RSP: 0018:ffffc90000a23ce0 EFLAGS: 00010293
	[    6.048999] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
	[    6.048999] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000002
	[    6.048999] RBP: ffffc90000a23d80 R08: 0000000000000060 R09: ffffffff81a7c510
	[    6.048999] R10: ffffc90000a23c00 R11: 0000000088092f04 R12: 0000000000000000
	[    6.048999] R13: 00000000000003e8 R14: 0000000000000000 R15: 0000000000000000
	[    6.048999] FS:  0000000001af5880(0000) GS:ffff88007f200000(0000) knlGS:0000000000000000
	[    6.048999] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	[    6.048999] CR2: 0000000000000000 CR3: 0000000079566000 CR4: 00000000000006f0
	[    6.048999] Call Trace:
	[    6.048999]  ? rcu_read_lock_sched_held+0x40/0x47
	[    6.048999]  ? kmem_cache_alloc_trace+0x1eb/0x29b
	[    6.048999]  ? x509_cert_parse+0x98/0x19f
	[    6.048999]  ? x509_cert_parse+0x98/0x19f
	[    6.048999]  x509_cert_parse+0xbc/0x19f
	[    6.048999]  x509_key_preparse+0x26/0x190
	[    6.048999]  asymmetric_key_preparse+0x3a/0x6a
	[    6.048999]  key_create_or_update+0x140/0x39d
	[    6.048999]  SyS_add_key+0x157/0x1ac
	[    6.048999]  entry_SYSCALL_64_fastpath+0x1f/0xc2
	[    6.048999] RIP: 0033:0x435389
	[    6.048999] RSP: 002b:00007ffd6792ae88 EFLAGS: 00000246 ORIG_RAX: 00000000000000f8
	[    6.048999] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000435389
	[    6.048999] RDX: 0000000000000000 RSI: 0000000000493ee4 RDI: 0000000000493ee9
	[    6.048999] RBP: 00007ffd6792ae70 R08: 00000000fffffffd R09: 0000000000000000
	[    6.048999] R10: 00000000000003e8 R11: 0000000000000246 R12: 00007ffd6792af88
	[    6.048999] R13: 00007ffd6792af98 R14: 0000000000000002 R15: 0000000000000000
	[    6.048999] Code: 75 0e 41 88 d2 41 80 e2 01 74 0f 4c 39 eb 75 0a 41 83 e6 fb 48 8b 45 80 eb 97 49 8d 4d ff 48 39 cb 0f 83 1c 03 00 00 49 8d 0c 1f <40> 8a 39 4c 8d 43 01 40 88 7d 8d 83 e7 1f 40 80 ff 1f 0f 84 00 
	[    6.048999] RIP: asn1_ber_decoder+0xe0/0x588 RSP: ffffc90000a23ce0
	[    6.048999] CR2: 0000000000000000
	[    6.073968] ---[ end trace d27c036692bbc3da ]---

- Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
