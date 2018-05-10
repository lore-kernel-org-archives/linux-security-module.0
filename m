From: alexei.starovoitov@gmail.com (Alexei Starovoitov)
Date: Thu, 10 May 2018 16:16:27 -0700
Subject: [PATCH v2 net-next 1/4] umh: introduce fork_usermode_blob() helper
In-Reply-To: <CAGXu5j+1p5ccFBjcKa3FDR4cQnbQn3cokbbhrwizoUyAAqFSTQ@mail.gmail.com>
References: <20180503043604.1604587-1-ast@kernel.org>
	<20180503043604.1604587-2-ast@kernel.org>
	<20180504195642.GB12838@wotan.suse.de>
	<CAGXu5j+1p5ccFBjcKa3FDR4cQnbQn3cokbbhrwizoUyAAqFSTQ@mail.gmail.com>
Message-ID: <20180510231625.ypn7ymq5roibucwd@ast-mbp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, May 10, 2018 at 03:27:24PM -0700, Kees Cook wrote:
> On Fri, May 4, 2018 at 12:56 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> > What a mighty short list of reviewers. Adding some more. My review below.
> > I'd appreciate a Cc on future versions of these patches.
> 
> Me too, please. And likely linux-security-module@ and Jessica too.
> 
> > On Wed, May 02, 2018 at 09:36:01PM -0700, Alexei Starovoitov wrote:
> >> Introduce helper:
> >> int fork_usermode_blob(void *data, size_t len, struct umh_info *info);
> >> struct umh_info {
> >>        struct file *pipe_to_umh;
> >>        struct file *pipe_from_umh;
> >>        pid_t pid;
> >> };
> >>
> >> that GPLed kernel modules (signed or unsigned) can use it to execute part
> >> of its own data as swappable user mode process.
> >>
> >> The kernel will do:
> >> - mount "tmpfs"
> >> - allocate a unique file in tmpfs
> >> - populate that file with [data, data + len] bytes
> >> - user-mode-helper code will do_execve that file and, before the process
> >>   starts, the kernel will create two unix pipes for bidirectional
> >>   communication between kernel module and umh
> >> - close tmpfs file, effectively deleting it
> >> - the fork_usermode_blob will return zero on success and populate
> >>   'struct umh_info' with two unix pipes and the pid of the user process
> 
> I'm trying to think how LSMs can successfully reason about the
> resulting exec(). In the past, we've replaced "blob" style interfaces
> with file-based interfaces (e.g. init_module() -> finit_module(),
> kexec_load() -> kexec_file_load()) to better let the kernel understand
> the origin of executable content. Here the intent is fine: we're
> getting the exec from an already-loaded module, etc, etc. I'm trying
> to think specifically about the interface.
> 
> How can the ultimate exec get tied back to the kernel module in a way
> that the LSM can query? Right now the hooks hit during exec are:
> kernel_read_file() and kernel_post_read_file() of tmpfs file,
> bprm_set_creds(), bprm_check(), bprm_commiting_creds(),
> bprm_commited_creds(). It seems silly to me for an LSM to perform
> these checks at all since I would expect the _meaningful_ check to be
> finit_module() of the module itself. Having a way for an LSM to know
> the exec is tied to a kernel module would let them skip the nonsense
> checks.
> 
> Since the process for doing the usermode_blob is defined by the kernel
> module build/link/objcopy process, could we tighten the
> fork_usermode_blob() interface to point to the kernel module itself,
> rather than leaving it an open-ended "blob" interface? Given our
> history of needing to replace blob interfaces with file interfaces,
> I'm cautious to add a new blob interface. Maybe just pull all the
> blob-finding/loading into the interface, and just make it something
> like fork_usermode_kmod(struct module *mod, struct umh_info *info) ?

I don't think it will work, since Andy and others pointed out that
bpfilter needs to work as builtin as well. There is no 'struct module'
in such case, but fork-ing of the user process still needs to happen.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
