From: casey@schaufler-ca.com (Casey Schaufler)
Date: Tue, 2 Jan 2018 09:20:06 -0800
Subject: Differentiating audit rules in an LSM stack
In-Reply-To: <2471440.Usxef9eJXA@x2>
References: <a1f773ca-924d-1428-c8b3-0bf77f6cf796@schaufler-ca.com>
	<CAHC9VhTDepkZ=073kuP25Jz-XAh4aK94tBb8tNGjxdz6c-1EPA@mail.gmail.com>
	<2471440.Usxef9eJXA@x2>
Message-ID: <61e6408b-0a70-8944-4be1-6c2e65f484f8@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Resending without HTML. Sorry 'bout that.

On 2/2/2018 7:48 AM, Steve Grubb wrote:
> On Friday, December 22, 2017 4:02:41 PM EST Paul Moore wrote:
> > On Fri, Dec 22, 2017 at 3:01 PM, Casey Schaufler <casey@schaufler-ca.com>
> wrote:
> > > The audit rule field types AUDIT_SUBJ_* and AUDIT_OBJ_* are
> > > defined generically and used by both SELinux and Smack to identify
> > > fields that are interesting to them. If SELinux and Smack are running
> > > concurrently both modules will identify audit rules as theirs if
> > > either has requested the field. Before I go off and create a clever
> > > solution I think it wise to ask if anyone has thought about or has
> > > strong opinions on how best to address this unfortunate situation.
> > >
> > > We know that SELinux and Smack together is not an especially
> > > interesting configuration. It is, however, a grand test case for
> > > generality of the solution. Any module that wanted to audit fields
> > > that are defined generically will have this sort of problem.
> >
> > I think the biggest concern here is going to be what Steve's audit
> > userspace will tolerate.  I might suggest simply duplicating the
> > fields for each LSM that is running, e.g. "subj=<selinux_label>
> > subj=<smack_label> subj=<lsmX_label> ...", but I have no idea if
> > Steve's userspace can handle multiple instances of the same field in a
> > single record.
>
>
> That would be bad in general because we have a field dictionary
> that defines the value side of the field=value. Another alternative
> might be to prepend an lsm specific abbreviation? This keeps the
> field dictionary correct.
>
>
> I originally thought we were talking about AVC's and reusing the
> same record type for the different LSM's. That would be simple to
> fix by just adding a "lsm=x" field at the beginning.
>
>
> But if we are talking about each and every syscall or path record,
> I think this will make things ugly fast. I'd prefer prepending
> an identifier to the field name so that we can do LSM specific
> reporting. I have never seen or heard of a system that has a
> subject or object with multiple labels. We don't even include
> supplemental groups in syscall records and that is usually pretty
> important information.

If an action fails because it's denied by SELinux I want an
audit record that includes the subject SELinux context and the
object SELinux context. If the action id denied by Smack, I would
like to see the Smack information. If the action requires a
capability I may want the Smack information and the SELinux
information. That could happen if the capability required is
CAP_MAC_ADMIN, for example. It's also possible that I'd only
want to see the information about the module that caused the
failure in the CAP_MAC_ADMIN case.

If I tell the audit system that I care about the MAC label
Crackle it's important that it set the triggers for Smack,
not SELinux. You can't auto-detect because SELinux contexts
are syntactically valid Smack labels.

If there's a DAC access failure do I need any MAC data in
the audit record? Do I need all of it? I personally would
want all the information all the time, but I can see how
such a view might be unpopular.

At the code level I'm struggling with the audit code that
calls security_secid_to_secctx(), how how best to determine
which, if any, of the available "contexts" to return. I am
also looking at the code for setting triggers and pondering
how it might be possible to look for a Smack label "Crackle"
without getting an error from SELinux, which does not like
that as a context.

I'm sort of hoping y'all will point out the obvious solution.
Short of that, I'd be happy with something that isn't obvious,
but would do the job. Or parts of it.

Thank you.

> > My initial thinking is that adding LSM-specific subj/obj fields would
> > be a mistake.
>
> How so? If someone wanted a selinux specific report, how else
> would you detangle which representation is selinux's?
>
> -Steve

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
