Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9D0C74A5B
	for <linux-security-module@archiver.kernel.org>; Thu, 30 Mar 2023 03:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjC3DfM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 29 Mar 2023 23:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjC3DfL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 29 Mar 2023 23:35:11 -0400
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9BD344C13
        for <linux-security-module@vger.kernel.org>; Wed, 29 Mar 2023 20:35:06 -0700 (PDT)
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 32U3YhUf001045;
        Wed, 29 Mar 2023 22:34:43 -0500
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 32U3YgbG001044;
        Wed, 29 Mar 2023 22:34:42 -0500
Date:   Wed, 29 Mar 2023 22:34:42 -0500
From:   "Dr. Greg" <greg@enjellic.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org
Subject: Re: [PATCH 02/14] Add TSEM specific documentation.
Message-ID: <20230330033442.GA1014@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20230204050954.11583-1-greg@enjellic.com> <20230204050954.11583-3-greg@enjellic.com> <CAHC9VhQnZhczVRifSnM-zv46Cb9OFuh=6ha+1zKJaOUK15=K5A@mail.gmail.com> <20230214115822.GA28408@wind.enjellic.com> <CAHC9VhQoj-aWrN5SxfkT2zaNmaKCG7VyYVvGsaHAbp5iA8OBZw@mail.gmail.com> <20230313225227.GA23057@wind.enjellic.com> <CAHC9VhSfQOw-q6b-DHL=zXFr7_Dw=44VxkDTpPp_=4XAZk2k7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhSfQOw-q6b-DHL=zXFr7_Dw=44VxkDTpPp_=4XAZk2k7g@mail.gmail.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Wed, 29 Mar 2023 22:34:43 -0500 (CDT)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Mar 22, 2023 at 07:45:26PM -0400, Paul Moore wrote:

Hi, I hope the week is going well for everyone.

> On Mon, Mar 13, 2023 at 6:52???PM Dr. Greg <greg@enjellic.com> wrote:
> > On Thu, Mar 02, 2023 at 11:15:56PM -0500, Paul Moore wrote:
> >
> > Hi Paul, thanks for sending along further comments.
> >
> > You note below that you haven't had time to look at the code since you
> > wanted to confirm the TSEM security model before moving forward.
> >
> > From a development perspective we are now three weeks into what will
> > become version 2 of the patch series.  So at this point I wouldn't
> > advocate spending a lot of time on the current patchset.
> >
> > That being said, if you some have time, we would appreciate a quick
> > look at the code on your part, with respect to style changes and the
> > like we can enforce in the second series, ie. ordering of local
> > variable declarations by length and the like.

> To be perfectly honest I'm still very concerned about some of the
> issues that I've seen in the docs, until that is sorted out I'm not
> sure there is much point in looking at the code.

I think those concerns can be resolved, see below for more
information, the second patch series that we are closing in on should
help address the concerns that are currently on the table.

That being said, since TSEM is a new codebase, we were hoping that you
could give us some guidance on function local variable ordering.
Reverse Christmas tree seems popular writ large in the kernel, I
believe that you commented in a posting a month or two ago that you
prefer standard Christmas tree, SMACK and SeLinux don't seem to
religiously embrace a style.

Our codebase uses ordering based on least complex to most complex
variables and has worked for us, both in the kernel and elsewhere, but
we are ambivalent, as our primary objective is to avoid wasting
everyone's time on issues such as this.

So we would look forward to a recommendation, given that it shouldn't
involve wasting any time looking at code.

> > > On Tue, Feb 14, 2023 at 6:58???AM Dr. Greg <greg@enjellic.com> wrote:
> > > > On Sun, Feb 12, 2023 at 11:33:26PM -0500, Paul Moore wrote:
> > > > > On Sat, Feb 4, 2023 at 12:33 AM Dr. Greg <greg@enjellic.com> wrote:
> > > > > >
> > > > > > An entry was added to the ABI testing documentation to document
> > > > > > the files in the TSEM management filesystem.
> > > > > >
> > > > > > The file documenting the kernel command-line parameters was
> > > > > > updated to document the tsem_mode command-line parameter.
> > > > > >
> > > > > > The primary TSEM documentation file was added to the LSM
> > > > > > administration guide and the file was linked to the index of LSM
> > > > > > documentation.
> > > > > >
> > > > > > Signed-off-by: Greg Wettstein <greg@enjellic.com>
> > > > > > ---
> > > > > >  Documentation/ABI/testing/tsemfs              |  576 ++++++++
> > > > > >  Documentation/admin-guide/LSM/index.rst       |    1 +
> > > > > >  Documentation/admin-guide/LSM/tsem.rst        | 1240 +++++++++++++++++
> > > > > >  .../admin-guide/kernel-parameters.txt         |    5 +
> > > > > >  4 files changed, 1822 insertions(+)
> > > > > >  create mode 100644 Documentation/ABI/testing/tsemfs
> > > > > >  create mode 100644 Documentation/admin-guide/LSM/tsem.rst
> > > >
> > > > > One of the more important requirements for any new LSM is that it
> > > > > documents a clear, understandable, and reasonable security model along
> > > > > with an implementation that faithfully implements that model.  Before
> > > > > I looked at your code I wanted to try and understand the TSEM security
> > > > > model and a few things jumped out at me rather quickly, I imagine
> > > > > there would be others as I start to look a bit closer but I wanted to
> > > > > send these questions/comments along now to get your take on them ...
> > > >
> > > > Hi Paul, thanks for taking time to review the documentation and raise
> > > > questions, responses below.
> > > >
> > > > > > diff --git a/Documentation/ABI/testing/tsemfs b/Documentation/ABI/testing/tsemfs
> > > > > > new file mode 100644
> > > > > > index 000000000000..3d326934624c
> > > > > > --- /dev/null
> > > > > > +++ b/Documentation/ABI/testing/tsemfs
> > >
> > > ...
> > >
> > > > > > +What:          /sys/fs/tsem/measurement
> > > > > > +Date:          November 2022
> > > > > > +Contact:       Greg Wettstein <greg@enjellic.com>
> > > > > > +Description:
> > > > > > +               The measurement file contains the ASCII base 16
> > > > > > +               hexadecimal representation of the 256 bit measurement
> > > > > > +               value of the security model that the process is
> > > > > > +               operating in.
> > > > > > +
> > > > > > +               The measurement value is the classic linear extension
> > > > > > +               measurement of the model.  An updated measurement
> > > > > > +               value is created by extending the current measurement
> > > > > > +               value with the state coefficient computed for a
> > > > > > +               security event.
> > > > > > +
> > > > > > +               This measurement value represents a time dependent
> > > > > > +               measurement of a model and is susceptible to
> > > > > > +               deviations caused by scheduling differences between
> > > > > > +               subsequent invocations of a workload.
> > > >
> > > > > Given the very volatile nature of this value, what is it used for in
> > > > > userspace?  My apologies if I missed it in the docs.
> > > >
> > > > It serves the same role as PCR register 10 in IMA, or any other
> > > > register in a TPM based architecture using a classic linear extension
> > > > mechanism strategy, it can be used to validate a list of time or
> > > > sequence ordered measurement values.
> > > >
> > > > Our personal prejudice is that these types of measurements are of
> > > > limited value, which is why we introduce in TSEM, the notion of the
> > > > 'state' value for a model, discussed below.
> > > >
> > > > I would have to go looking on lore for a reference to the exact thread
> > > > but Roberto Sassu had offered up a patch set for IMA that addressed
> > > > the deficiency of these types of measurements.
> >
> > > If we all agree that this measurement isn't very useful, and you
> > > have implemented an alternative which is intended to address these
> > > usability shortcomings, why bother including this measurement in
> > > TSEM?
> >
> > To provide comparable functionality to TPM based security
> > architectures, that are currently, considered state of the art for the
> > security industry.
> >
> > As our documentation calls out, TSEM's concept of Trusted Modeling
> > Agent's (TMA's), are being proposed to both explore and implement next
> > generation hardware assisted security technologies.
> >
> > Currently, the only measurements that TPM based systems support are
> > classic linear extension summing, which I believe we all consider to
> > be problematic.
> >
> > That being said, the 'measurement' value can be used to validate the
> > order of the security event execution trajectory.  In that role it
> > provides the same value that PCR register 10 plays for IMA.
> >
> > We believe there is a legitimate discussion that can occur, as to
> > whether or not this classic attestation architecture is relevant, but
> > it seemed appropriate to support it.
> 
> It is relatively easy to add user visible features to the kernel, but
> it's almost impossible to remove them.  If you see little value in
> feature X, to the point that you've developed an alternate mechanism
> to avoid the shortcomings which limit the usefulness of X, why include
> it?  If you later realize that it is important you can always add it.
> 
> Add new functionality to the kernel because it meets a user need, not
> simply because "everybody else is doing it".  If you've got a defined
> use case for this, keep it; however, if you can't define a reasonable
> use case I would suggest dropping it and making your life easier.

The discussion on this has caused us to implement changes, that will
be in V2, that should better justify the measurement value, but see
below.

> > > It's relatively easy to add features to the Linux Kernel as time
> > > goes on, it is *very* difficult to remove them.  For this initial
> > > submission I would encourage you to implement the bare minimum
> > > functionality you need to do something useful and meet your goals.
> >
> > We can certainly pull the export of the measurement value.  In that
> > case, would you recommend that we also pull the code that extends the
> > security coefficients from the root modeling domain, if a TPM is
> > available, into PCR register 11?
> 
> Once again, if you've got a use case, keep it; if not, drop it.  Don't
> add to the kernel API without a use case.
> 
> > > > > > +What:          /sys/fs/tsem/trajectory
> > > > > > +Date:          November 2022
> > > > > > +Contact:       Greg Wettstein <greg@enjellic.com>
> > > > > > +Description:
> > > > > > +               The trajectory file contains a description of the
> > > > > > +               security events that have occurred in a security
> > > > > > +               domain/model.
> > > > > > +
> > > > > > +               Each entry in this file represents a single security
> > > > > > +               event and consists of brace {} delimited fields that
> > > > > > +               describe the characteristics of a security event.
> > > > > > +               Each field has key=value pairs that define
> > > > > > +               characteristics of the field.
> > > > > > +
> > > > > > +               Each line in a trajectory, or forensics, file will
> > > > > > +               always have the event{} and COE{} fields.  The event
> > > > > > +               field describes the characteristics of a security
> > > > > > +               event while the COE field describes the Context Of
> > > > > > +               Execution that is executing the security event.
> > > >
> > > > > I think it would be good to provide a concrete definition of
> > > > > CELL_DEFINITION field as other areas of the documentation make
> > > > > reference to it within the tsem/trajectory file documentation.  We can
> > > > > somewhat infer it's format, fields, etc. but it's much better to be
> > > > > explicit about these things.
> > > >
> > > > Valid point, we will incorporate a broad definition of what the 'CELL'
> > > > represents.
> > > >
> > > > Conceptually, it is equivalent to the 'object' in mandatory access
> > > > controls.  In an events based architecture like TSEM, it is
> > > > essentially the 'bucket' of values that describe the parameters of a
> > > > security event that a COE/process is requesting permission for.
> >
> > > Yes, I understood conceptually what it represents and what data
> > > might be present given a specific operation/rule, but it wasn't
> > > clear to me how that data would be represented in the
> > > CELL_DEFINITION.
> >
> > As a bit of further clarification, regarding the security model that
> > TSEM is based on.
> >
> > A TMA extracts the event description parameters, now encoded in
> > JSON.. :-), into a structure and then computes a digest value,
> > referred to as the 'CELL identity value', over those elements, in
> > whatever order the TMA elects to do so in.
> >
> > Further, a TMA implementation may elect to only include certain
> > characteristics in the computation of the CELL identity, depending on
> > the model being implemented.
> >
> > > > > > +               The event{} field consists of the following
> > > > > > +               characteristic definitions:
> > > >
> > > > > I'm unclear as to the purpose of the event{} field as it is neither
> > > > > part of the COE or the CELL, is it here simply to make the event
> > > > > easier to read?  Or am I misunderstanding things and the event{}
> > > > > field is part of the COE?
> > > >
> > > > It actually serves two roles, one of which, as you note, is to make
> > > > the event description easier to read and understand.
> > > >
> > > > It probably comes as no surprise, but the trust orchestration system
> > > > that this is all designed to support, has a security console that can
> > > > be used to review the status of all the trust orchestrators that are
> > > > supervising security workloads.  Either in the cloud, or perhaps, a
> > > > large body of edge devices protecting critical infrastructure, if that
> > > > doesn't give away too much.... :-)
> > > >
> > > > Having the process name and executable easily visualized is fairly
> > > > useful.
> > > >
> > > > The second role is to allow the event description records to be
> > > > self-describing.  The value for the type= key is used by the Trusted
> > > > Modeling Agent (TMA) to determine what to look for in the remainder of
> > > > the event description record in order to compute the CELL value.
> > > >
> > > > It also contains the TASK_ID value that ties the security state points
> > > > to the integrity of the executable.  Since that value is a synthetic
> > > > value it was deemed most appropriate to be placed in the event{}
> > > > field.
> >
> > > I think it would be good to provide a more succinct version of the
> > > above in the documentation.
> >
> > We will clarify that.
> >
> > > > > > +                       process=COMM
> > > > > > +                               Where COMM is the ASCII representation
> > > > > > +                               of the name of the process executing
> > > > > > +                               the event.
> > > > > > +
> > > > > > +                       filename=PATH
> > > > > > +                               If the CELL definition for an event
> > > > > > +                               references a file the filename
> > > > > > +                               characteristic contains a definition
> > > > > > +                               of the path to the file.
> > > > > > +
> > > > > > +                               In the case where an event does not
> > > > > > +                               have a file the PATH value is set to a
> > > > > > +                               value of none.
> > > >
> > > > > What happens in cases where multiple file paths are present in an
> > > > > event?  Also, given this is visible to userspace, and multiple
> > > > > things can affect the path to a file (e.g. namespaces), how is the
> > > > > file path determined?
> > > >
> > > > Unless we have missed something, which is no doubt possible, all of
> > > > the security event hooks that we have implemented, which number about
> > > > 87 now, that act on a 'file', receive only a single 'struct file *'
> > > > pointer as a parameter to the event.
> > > >
> > > > So we haven't encountered a situation where there would be multiple
> > > > files for a single event description.
> >
> > > I haven't seriously looked at the TSEM sources yet, I'm trying to
> > > make sure that I first understand the security model while also
> > > ensuring that it is well documented and reasonable.  While I can't
> > > speak to what LSM hooks TSEM implements, it seems like there are at
> > > least a few operations, rename and link come immediately to mind,
> > > which would have multiple filenames as part of the operation.  How
> > > are those operations handled in TSEM, or are they outside the scope
> > > of TSEM?
> >
> > We are currently handling them as generically modeled events so the
> > current model treats them as whether or not they occurred.
> >
> > When they get promoted to explicitly modeled events, the current
> > presumption would be to include the involved filenames in the
> > description of the event.

> Hmmm.
> 
> With the understanding that I didn't go re-read the docs just now, my
> gut feeling is that omitting/downgrading events like rename/link/etc.
> from the modeling is a pretty significant shortcoming given the
> importance of filenames as an identifier in the TSEM events.  The fact
> that you chose to say "When they get promoted ..." as opposed to "If
> they get promited ..." appears to add some credibility to that
> thought.
>
> However, I will be honest and say that I'm not sure I recall the
> difference between "generically modeled" and "explicitly modeled"
> events in the context of TSEM.  Perhaps that would make this clear,
> maybe it wouldn't.
> 
> Regardless, can you help me understand why this isn't a concern for
> this initial effort and why you've decided to add this later?

Least complex answer; minimalism in the initial implementation, which
from your previous comments would seem to be a virtue.

Slightly more complex; the current models that we are training don't
benefit from numerical resolution beyond what is in the initial
implementation.

Some clarifications that may be useful:

Filenames are no more, or no less, important in TSEM than any of the
other parameters of the security event basis set.  The security
relevant entity is the coefficient that gets computed for the event.

As the 'Event modeling' section of the TSEM documentation points out,
the security coefficient is a functional product of the event, task,
COE and CELL identities.  Simplisticaly, a generically modeled event
operates under the presumption that the security model will only be
dependent on whether or not a particular portion of executable memory,
executed by a process with defined characteristics, is requesting
approval for a specific security event.

If the (EVENT:TASK:COE) tuple has not been shown to generate, for
example, a filename rename, the event will be denied.  If a rename is
allowed, and it results in a pathname that has not been included in
the model, an attempt to subsequently access the file will also result
in a pertubation of the model state.

A critical element in all of this is the notion of modeling namespaces
that reduce the complexity scope of the implemented models.  As an
additional, and hopefully helpful example, a micro-services
application running in a container may never demonstrate the need to
rename or unlink a file.  An attempt to do so, if for example the
application were compromised, will be denied, regardless of the object
of the rename.

We have additional work that will be forthcoming on this issue, but as
you noted above, and in the last e-mail, better to be simple first.

> > > > > > +                       euid=NN
> > > > > > +                               The ASCII base 10 representation of
> > > > > > +                               the numeric value of the effective
> > > > > > +                               discretionary user id of the process
> > > > > > +                               that is executing the security event.
> > > > > > +
> > > > > > +                       euid=NN
> > > > > > +                               The ASCII base 10 representation of
> > > > > > +                               the numeric value of the effective
> > > > > > +                               discretionary user id of the process
> > > > > > +                               that is executing the security event.
> > > > > > +
> > > > > > +                       suid=NN
> > > > > > +                               The ASCII base 10 representation of
> > > > > > +                               the numeric value of the saved user id
> > > > > > +                               of the process that is executing the
> > > > > > +                               security event.
> > > > > > +
> > > > > > +                       gid=NN
> > > > > > +                               The ASCII base 10 representation of
> > > > > > +                               the numeric value of the discretionary
> > > > > > +                               group id of the process that is
> > > > > > +                               executing the security event.
> > > > > > +
> > > > > > +                       egid=NN
> > > > > > +                               The ASCII base 10 representation of
> > > > > > +                               the numeric value of the discretionary
> > > > > > +                               effective group id of the process that
> > > > > > +                               is executing the security event.
> > > > > > +
> > > > > > +                       egid=NN
> > > > > > +                               The ASCII base 10 representation of
> > > > > > +                               the numeric value of the discretionary
> > > > > > +                               effective group id of the process that
> > > > > > +                               is executing the security event.
> > > > > > +
> > > > > > +                       sgid=NN
> > > > > > +                               The base 10 ASCII representation of
> > > > > > +                               the numeric value of the saved
> > > > > > +                               discretionary group id of the process
> > > > > > +                               that is executing the security event.
> > > > > > +
> > > > > > +                       fsuid=NN
> > > > > > +                               The base 10 ASCII representation of
> > > > > > +                               the numeric value of the discretionary
> > > > > > +                               filesystem user id of the process that
> > > > > > +                               is executing the security event.
> > > > > > +
> > > > > > +                       fsgid=NN
> > > > > > +                               The ASCII base 10 representation of
> > > > > > +                               the numeric value of the discretionary
> > > > > > +                               filesystem group id of the process
> > > > > > +                               that is executing the security event.
> > > > > > +
> > > > > > +                       cap=0xNNN
> > > > > > +                               The ASCII base 16 representation of
> > > > > > +                               the numeric value of effective
> > > > > > +                               capabilities of the process that is
> > > > > > +                               executing the security event.
> > > > > > +
> > > > > > +               If the CELL value for a security event includes the
> > > > > > +               definition of a file a file{} event field will be
> > > > > > +               included.  The following characteristics will be
> > > > > > +               encoded in this field:
> > > > > > +
> > > > > > +                       flags=NN
> > > > > > +                               The ASCII base 10 representation of
> > > > > > +                               the flags value of the 'struct file'
> > > > > > +                               structure that is the source of the
> > > > > > +                               file description.
> > > > > > +
> > > > > > +                       uid=NN
> > > > > > +                               The ASCII base 10 representation of
> > > > > > +                               the discretionary user id of the file.
> > > > > > +
> > > > > > +                       gid=NN
> > > > > > +                               The base 10 ASCII representation of
> > > > > > +                               the discretionary group id of the
> > > > > > +                               file.
> > > >
> > > > > Similar to the task UID/GID mapping questions above, there are
> > > > > mechanisms which map the file user/group IDs, which will be used in
v> > > > > the CELL definition and how will that be resolved between the kernel
> > > > > and an external modeler?
> > > >
> > > > The answer is the same as with the COE, see the following function:
> > > >
> > > > security/tsem/event.c:get_file_cell()
> > > >
> > > > Once again, the TMA only operates on the event description presented
> > > > to it and is not influenced by its own namespace.
> >
> > > For this particular point, my concern isn't what policy the TMA
> > > implements, or what it uses as input, it's about understanding how
> > > this event information is collected.  For fields which can be
> > > namespaced (I'm referring to "normal" Linux Kernel namespaces and
> > > not any TSEM namespaces), the TSEM documentation should make it
> > > clear which namespace is used as a basis for the value.
> >
> > FWIW, based on feedback we have received, there may be a modeling
> > domain/namspace setup option forthcoming that allows a trust
> > orchestrator to request that the uid/gid et.al characteristics be
> > exported in the context of the current user namespace.

> Please make sure you are explicit in which "current user namespace":
> the namespace which generated the event, or the namespace in which
> the modeling agent is running.  You should also provide some
> guidance on how to handle issues that might arise when the two
> namespaces (generating namespace, modeler namespace) are different.
> If you don't plan to allow the modeling agent to run in a separate
> namespace from the generating event stream please explain how that
> requirement will be enforced by the kernel.

We have already validated the implementation for allowing the user
namespace reference for a modeling domain to be selected on a domain
by domain basis.

We will document these issues, FWIW, some clarifications that may be
helpful for those following this discussion.

For an internally modeled domain, there are no separate entities to be
concerned about.  The processes that execute in the context of the
domain will model their events based on whatever user namespace they
are in.  If the user namespace changes, the representative
characteristics being used will change, which would seem to be
reasonable, if the domain has been configured to be sensitive to the
user namespace mappings that the process is running in.

In an externally modeled domain, by definition, the modeling process
must be in a different modeling domain than the modeled process.  Our
reference to Heisenberg, in the documentation, was not by
happenstance, the act of modeling would perturb the state of the
modeled system.

The modeling process and the modeled processes can run in separate or
different user namespaces.  The modeling process and the modeled
processes will generate and report their derived security state
coefficients to different modeling domains.

> > > > > > +What:          /sys/fs/tsem/ExternalTMA
> > > > > > +Date:          November 2022
> > > > > > +Contact:       Greg Wettstein <greg@enjellic.com>
> > > > > > +Description:
> > > > > > +               The ExternalTMA directory is a container directory
> > > > > > +               that hold files that will be used to export the
> > > > > > +               security events, and their associated parameters, for
> > > > > > +               externally modeled security domains/namespaces.
> > > > > > +
> > > > > > +               The files created in this directory will be named by
> > > > > > +               the base 10 ASCII representation of the id value
> > > > > > +               assigned to the modeling domain/namespace.  See the
> > > > > > +               documentation for the /sys/fs/tsem/id file in this
> > > > > > +               documentation for more details on this value.
> > > > > > +
> > > > > > +               This file will is a read-only file that can be polled
> > > > > > +               by a userspace trust orchestration implementation to
> > > > > > +               process security events that are to be modeled by
> > > > > > +               an external Trusted Modeling Agent.
> > > > > > +
> > > > > > +               The type of the exported event is the first keyword of
> > > > > > +               the line that is output and have the following
> > > > > > +               values and arguments:
> > > > > > +
> > > > > > +               aggregate HEXID:
> > > > > > +                       Where HEXID is the ASCII base 16
> > > > > > +                       representation of the 256 bit hardware
> > > > > > +                       platform aggregate value.
> > > > > > +
> > > > > > +               export pid{NNN} COE{} CELL_DEFINITION
> > > > > > +                       Where the NNN in the pid field is the ASCII
> > > > > > +                       base 10 value of the id of the process that is
> > > > > > +                       executing the security event that will be
> > > > > > +                       modeled.
> > > >
> > > > > I worry whenever I see a PID used as an identifier shared across the
> > > > > kernel/userspace boundary as it is inherently racy.  Given the
> > > > > somewhat coarse COE definition where one can expect multiple
> > > > > processes/PIDs to share the same COE value, and the ability of
> > > > > untrusted users/processes to manipulate the PID table, what do you
> > > > > expect to use the pid{NNN} field for in this event?
> > > > >
> > > > > Similar to the other namespace/mapping issues discussed previously,
> > > > > there is also the PID namespace issue to worry about.  How is that
> > > > > handled here?
> > > >
> > > > The concern over the PID issue is understandable, I will treat the
> > > > reasoning behind its use below.
> > > >
> > > > The PID value is the 'native' value managed by the kernel, not a
> > > > mapped value.
> >
> > > Regardless of if the PID is rooted in the initial namespace or a
> > > different PID namespace, the issue of PIDs being inherently racy is
> > > a real problem.  Can you help me understand how TSEM avoids the
> > > common pitfalls associated with using PIDs to identify processes on
> > > the system?
> >
> > The second version of the TSEM series, now includes support for a
> > requirement that a process being externally modeled, authenticate
> > itself to the TMA in order for the trust control call to act on
> > the process.

> Please bear with me, I want to make sure I'm clear on this point.
> In order for a process to be modeled by an external
> modeling-agent/TMA it would need to first authenticate with the TMA
> (using a TBD mechanism); is that correct?

Yes, somewhat more specifically, we implemented the requirement for
mutual authentication between an external TMA and the modeled process.

> I guess we will need to see how the authentication works, but is
> there a mechanism in place to ensure that a malicious process could
> not pass an authentication token to another (PID recycled) process?

If we understand the concern correctly, this would imply that a
malicious process has read/write access to arbitrary kernel memory
that it is not allowed to access, which would seem to represent a
catastrophic security event that cannot be defended against.

I think the appropriate metaphor, in classic subject/object security
models, would be if a malicious process had the ability to modify
either its own or another processes label, i.e if CAP_MAC_ADMIN were
lost to an adversary.

> Do you plan to support unauthenticated external modeling?  If so,
> how do you plan to address PID recycling?

The current codebase no longer supports anything other than
authenticated trust control.

> > > > > > +What:          /sys/fs/tsem/control
> > > > > > +Date:          November 2022
> > > > > > +Contact:       Greg Wettstein <greg@enjellic.com>
> > > > > > +Description:
> > > > > > +               The control file is the only writable file in the
> > > > > > +               filesystem and is used by the trust orchestrators to
> > > > > > +               configure and control the behavior of the TSEM
> > > > > > +               implementation.
> > > > > > +
> > > > > > +               The following keyword and arguments are recognized:
> > > > > > +
> > > > > > +               internal:
> > > > > > +                       The internal keyword causes an internally
> > > > > > +                       modeled domain to be created for the calling
> > > > > > +                       process.
> > > > > > +
> > > > > > +               external:
> > > > > > +                       The external keyword causes an externally
> > > > > > +                       modeled domain to be created for the calling
> > > > > > +                       process.
> > > > > > +
> > > > > > +               enforce:
> > > > > > +                       The enforce keyword causes the modeling
> > > > > > +                       domain/namespace of the process to enter
> > > > > > +                       enforcing mode.  In this mode a value of
> > > > > > +                       -EPERM will be returned for a security event
> > > > > > +                       that does not map into the current set of
> > > > > > +                       allowed state points for the security model
> > > > > > +                       being implemented for the domain/namespace.
> > > > > > +
> > > > > > +               seal:
> > > > > > +                       The seal keyword causes the security model
> > > > > > +                       being implemented for the model to be placed
> > > > > > +                       in sealed state.  In this state the current
> > > > > > +                       set of security event points is considered to
> > > > > > +                       be the only set of valid points for the
> > > > > > +                       domain/model.  Any subsequent events that map
> > > > > > +                       to a point not in the current model will be
> > > > > > +                       considered a violation of the model.
> > > > > > +
> > > > > > +               trusted PID:
> > > > > > +                       The trusted keyword is used by a trust
> > > > > > +                       orchestrator to indicate that the process
> > > > > > +                       identified by the PID argument should be
> > > > > > +                       allowed to run in trusted status.
> > > > > > +
> > > > > > +               untrusted PID:
> > > > > > +                       The untrusted keyword is used by a trust
> > > > > > +                       orchestrator to indicate that the process
> > > > > > +                       identified by the PID argument should be
> > > > > > +                       allowed to run but designated as an untrusted
> > > > > > +                       process.
> > > >
> > > > > The 'trusted PID:' and 'untrusted PID:' commands are concerning for
> > > > > the reasons described above about PIDs being racy and generally an
> > > > > unreliable way of identifying processes across the kernel/userspace
> > > > > boundary.  I suspect it would not be too difficult for a malicious
> > > > > user to trick an external modeler into marking the wrong process as
> > > > > trusted/untrusted.
> > > >
> > > > An external TMA needs the PID value to determine which process to wake
> > > > up and set the trust status value on in the task control structure,
> > > > after the event is modeled.  As was noted above, the PID value is the
> > > > unmapped value maintained by the OS.
> > > >
> > > > Lets see if we can reason through why the PID can be used safely.
> > > >
> > > > CAP_TRUST, or whatever ends up getting used, is required by the trust
> > > > orchestrator to create a security/modeling namespace for the workload
> > > > being modeled.  This results in the creation of the following
> > > > pseudo-file for surfacing the security event descriptions for the
> > > > namespace/workload:
> > > >
> > > > /sys/fs/tsem/ExternalTMA/N
> > > >
> > > > Where N is the id number of the modeling domain.
> > > >
> > > > CAP_TRUST, caveats applied, is required to open the pseudo-file.  The
> > > > trust orchestrator only receives and acts on PID values through this
> > > > conduit from the kernel.
> > > >
> > > > When an event description is exported, the trust status of the task is
> > > > set to 'pending' and the process is placed in interruptible sleep and
> > > > scheduled away, with the 'wakeup' criteria being the trust status
> > > > being changed from pending to either trusted or untrusted.
> > > >
> > > > The only path to change the trust status value in the LSM task control
> > > > structure and wake up the process is by the trust orchestrator that
> > > > created the namespace, by writing the appropriate value to the
> > > > /sys/fs/tsem/control file.  Access to that file is gated by CAP_TRUST
> > > > or its equivalent.
> > > >
> > > > See the following code locations for further details:
> > > >
> > > > security/tsem/export.c:tsem_export_event()
> > > >
> > > > security/tsem/fs.c:control_COE()
> > > >
> > > > As long as the process 'exists', albeit sleeping, the PID slot is
> > > > occupied and an adversary, regardless of namespace, cannot substitute
> > > > a task with the same PID value.
> > > >
> > > > This leaves an adversary with the need to terminate the task being
> > > > modeled in order to capture its PID slot.
> > > >
> > > > Precautions are implemented in the following function to protect the
> > > > process from being terminated by an adversary:
> > > >
> > > > security/tsem/tsem.c:tsem_task_kill()
> >
> > > What about the OOM killer?
> > >
> > > The security_task_kill() LSM hook only offers an access control point
> > > for one process sending another process a signal, it doesn't gate a
> > > process being killed for other reasons.  The OOM killer is the first
> > > thing that comes to mind, but I'm reasonably certain there are other
> > > similar scenarios.
> >
> > As noted above, as an additional protection, the next version of the
> > series requires that a process authenticate itself as being a member
> > of the modeling domain in order for the trust status control call to
> > succeed.
> >
> > With this implementation, substituting an alternate process would now
> > require that an adversary break the security context between the TMA
> > and process in the modeling domain.

> I'll look forward to seeing the new authentication mechanism.  Please
> ensure it is properly documented.

The full details will be there.

> > > > > > +Process and Platform Trust Status
> > > > > > +=================================
> > > > > > +
> > > > > > +A fundamental concept in TSEM is the notion of providing a precise
> > > > > > +definition for what it means for a platform or workload to be trusted.
> > > > > > +A trusted platform or workload is one where there has not been an
> > > > > > +attempt by a process to execute a security relevant event that does
> > > > > > +not map into a known security state point.
> > > > > > +
> > > > > > +The process trust status is a characteristic of the process that is
> > > > > > +passed to any subordinate processes that are descendants of that
> > > > > > +process.  Once a process is tagged as untrusted, that characteristic
> > > > > > +cannot be removed from the process.  In a 'fruit from the poisoned
> > > > > > +vine' paradigm, all subordinate processes created by an untrusted
> > > > > > +process are untrusted as well.
> > > > > > +
> > > > > > +On entry into each TSEM security event handler, the trust status of a
> > > > > > +process is checked before an attempt to model the event is made.  An
> > > > > > +attempt to execute a security event by an untrusted process will cause
> > > > > > +the event, and its characteristics, to be logged.  The return status
> > > > > > +of the hook will be determined by the enforcement state of the model.
> > > > > > +A permission denial is only returned if the TMA is running in
> > > > > > +enforcing mode.
> > > > > > +
> > > > > > +If the platform running the TSEM LSM has a TPM, the hardware aggregate
> > > > > > +value is computed at the time that TSEM is initialized.  This hardware
> > > > > > +aggregate value is the linear extension sum over Platform
> > > > > > +Configuration Registers (PCR's) 0 through 7.  This is the same
> > > > > > +aggregate value that is computed by the Integrity Measurement
> > > > > > +Architecture (IMA) and is the industry standard method of providing an
> > > > > > +evaluation measurement of the hardware platform state.
> > > > > > +
> > > > > > +Internally model domains have the hardware aggregate measurement
> > > > > > +included as the first state point in the security model.  Externally
> > > > > > +modeled domains export the hardware aggregate value to the TMA for
> > > > > > +inclusion as the first state point of the model maintained by the TMA.
> > > > > > +
> > > > > > +The root modeling domain extends each security state point into PCR
> > > > > > +11.  This allows hardware based TSEM measurements to coexist with IMA
> > > > > > +measurement values.  This hardware measurement value can be used to
> > > > > > +attest to the security execution trajectory that the root model
> > > > > > +maintains.
> > > >
> > > > > It seems like making the target PCR configurable would be a good
> > > > > idea, at the very least make it a Kconfig option.
> > > >
> > > > That was something that we have thought about, it probably needs a
> > > > Kconfig option.
> > > >
> > > > Contrary to all appearances, as a team we are really minimalists at
> > > > heart and tend to not make things more complex or configurable than
> > > > needed.... :-)
> > > >
> > > > > Also, can you elaborate on how the security state points are
> > > > > extended into the PCR?  I imagine for it to be useful at an
> > > > > arbitrary point in time this would require the PCR to be extended as
> > > > > the security points were generated, which would imply that the PCR
> > > > > value would be dependent on execution order, and in most cases,
> > > > > scheduling order as well.  How useful do you expect this to be for
> > > > > most users?
> > > >
> > > > Your assessment is correct, the state points are extended into the PCR
> > > > whenever a unique security state point is generated.
> > > >
> > > > In a 'free-running' model, the value in the register will be fungible
> > > > due to scheduling dependencies.
> >
> > > In other words, garbage ;)
> >
> > We don't disagree on the utility of a scheduling fungible measurement
> > value.  However, this is an remarkably interesting
> > conclusion/statement, by the Linux security sub-system maintainer no
> > less, given that it describes the current state of the art with
> > respect to hardware security co-processors and trusted system
> > technology.. :-)

> I've yet to meet a kernel maintainer that doesn't hold amusing
> opinions on at least one issue; one could almost make an argument that
> it is a prerequisite for the role.  However, I feel that using
> non-deterministic values as a measure of system state/attestation is
> well understood to be garbage and isn't quite as interesting as you
> would make it.
>
> Based on the rest of the TSEM docs and this discussion, I'm guessing
> you are referencing IMA's measurements into PCR 10, or something
> similar, when you talk about the current state of the art, is that
> correct?

Yes.

> In the case of IMA, the important thing to remember is that PCR 10
> can be reliably attested using the IMA measurement log; the IMA
> project even provides tools and documentation demonstrating how to
> do so.  Does TSEM offer a similar measurement log?

Yes, in TSEM, the 'measurement' value can be used to validate the
order that the security state coefficients, ie. the values surfaced in
the /sys/kernel/security/tsem/points pseudo-file, were generated in.

> My apologies if I missed it.

I always tell people that all of this is straight forward, but there
is probably a lot here.

> > > > If the model is pre-defined, the security state points will be
> > > > extended into the register as they are loaded through the
> > > > /sys/fs/tsem/map pseudo-file interface.  In this case, the value will
> > > > be fixed and any departure from the value would signal that the
> > > > modeling domain has departed from its specification.
> > > >
> > > > With respect to the utility of the value, in a 'free-running' model it
> > > > is about as useful as the value that IMA maintains in PCR 10, which in
> > > > our opinion is not very useful and is why we implemented the notion of
> > > > the 'state' value of a model.
> >
> > > For a variety of reasons, and mostly to help keep things civil,
> > > let's refrain from comparing one LSM to another.  Each LSM makes its
> > > own choices, and needs to stand on its own; just because LSM did X
> > > doesn't mean TSEM can do X if it is silly in the context of TSEM.
> >
> > Our intent was not to be incivil, but rather to call out one of the
> > motivations in the implementation of TSEM, and in a larger context,
> > the notion of a TMA based security architecture.
> >
> > A now prehistoric version of TSEM was implemented as a patch on top of
> > IMA.  We actually built systems for clients on top of that
> > architecture.  Our concept of a 'state' value was driven by the
> > difficulties we experienced in implementing, and maintaining, these
> > systems in a field environment.
> >
> > We offer the concept of a 'state' value in order to simplify the
> > attestation model, which classically, has required that a verifying
> > party review an event log for its validity, after verifying that the
> > measurement value confirms the integrity of the log.

> Having a log ordered by the sequence of events can be important.
> After all, if a security critical configuration knob is toggled
> multiple times, and the event ordering is not preserved, how does one
> know the current state of the system?  I might be able to see that the
> knob was turned both on and off, but without knowing which occurred
> last, how do I know if the system is in a known good state?

Yes, that is classically the explanation that is given for having an
ordered event log.  That being said, we tend to struggle with the
validity of this thinking, that is not criticism, perhaps more of a
lack of understanding on our part.

Let's consider IMA, or TSEM running in a model context that only
observes the integrity of binaries run with root privileges, roughly
equivalent implementations.  In either scenario, you have an
attestation of the fact that a known binary executed in a known
temporal order, but does that tell you the final state of the system
from a security perspective?

Take iptables as an example, given its potential contribution to the
trust status of a system.  If you know that it executed twice, can it
be effectively reasoned what it was doing each time it executed,
without access to things like the command-line arguments?

Conceptually, in an extremely static system configuration, the rule
might be that system attestation fails if iptables ran more than once,
but in a multi-execution scenario it is unclear what can be reasoned.

> > > > > > +Internal vs external modeling
> > > > > > +-----------------------------
> > > > > > +
> > > > > > +When a TSEM modeling domain is created, a designation is made as to
> > > > > > +whether the domain is to be internally or externally modeled.
> > > > > > +
> > > > > > +In an internally modeled domain, the security event handlers pass the
> > > > > > +event type and its characteristics to the designated internal trusted
> > > > > > +modeling agent.  The agent provides the permission value for the
> > > > > > +security event handler to return as the result of the event and sets
> > > > > > +the trust status of the process executing the event.
> > > > > > +
> > > > > > +In an externally modeled domain, the event type and parameters are
> > > > > > +exported to userspace for processing by a trust orchestrator with an
> > > > > > +associated TMA.  The trust orchestrator communicates the result of the
> > > > > > +modeling back to the kernel to support the setting of the process
> > > > > > +trust status.
> > > > > > +
> > > > > > +This model poses a limitation to the ability of TSEM to model some
> > > > > > +security events.  This is secondary to the fact that some event
> > > > > > +handlers (LSM hooks) are called from a non-sleeping context, as a
> > > > > > +result the process cannot be scheduled.  This is particularly the case
> > > > > > +with the task based hooks, since they are typically called with the
> > > > > > +tasklist lock held.
> > > > > > +
> > > > > > +This limitation is also inherent to the root model that extends the
> > > > > > +security state points into TPM PCR 11, secondary to the fact that the
> > > > > > +process invoking the security event hook will be scheduled away while
> > > > > > +the TPM transaction completes.
> > > > > > +
> > > > > > +Addressing this problem directly requires a consideration of the
> > > > > > +context from which the security event handlers are being called.
> > > > > > +Subsequent implementations of TSEM will include a mechanism for
> > > > > > +asynchronous deferral of model processing, until when and if, a review
> > > > > > +of the call context would be considered worthwhile by the LSM
> > > > > > +community.
> > > >
> > > > > This is a pretty big limitation, and in conjunction with the some of
> > > > > the other issues brought up earlier (the PID issue seems the most
> > > > > concerning), I'm having a difficult time believeing that an external
> > > > > modeler could operate safely given the design presented here.
> > > >
> > > > With respect to the PID issue, we would welcome any comments on the
> > > > analysis that we provided above as to its design safety.
> > >
> > > >From what I can tell from the documentation and our discussion thus
> > > far is that TSEM relies on a security_task_kill() hook implementation
> > > to ensure that a process is not killed, and the PID released, without
> > > explicit TSEM approval.  Unfortunately, I believe that relying solely
> > > on security_task_kill() will not fully cover all of the cases where a
> > > process can be killed, mostly because security_task_kill() does not
> > > control process destruction, it controls the ability of one process to
> > > signal another.
> >
> > > You might be able to do something with security_task_free(), but I
> > > haven't given that much thought.
> >
> > Our analysis suggested that an authentication strategy was the
> > strongest and most complete implementation moving forward.
> 
> I'll look for that in the next revision.
> 
> > > > If the PID issue remains a concern, we have an extension to the export
> > > > descriptions that would include a random nonce that would be emitted
> > > > with the PID.  The nonce would be placed in the LSM task control
> > > > 'blob' for the sleeping task and used to confirm that the task release
> > > > directive was acting on the correct process.
> >
> > > That should help, but ultimately a nonce is still a bounded resource
> > > and subject to recycling just like the PID.  I'm open to hearing
> > > other ways in which you believe you can resolve this issue, but I
> > > remain skeptical.
> >
> > FWIW, I believe that current thinking is that a nonce based on a
> > 64-bit value is immune from recycling.  The classic metric for a
> > 64-bit counter is that a consumption rate of 1000 values/second yields
> > a counter cycle time of 584,942,417 years.  Nanosecond rates still
> > buys you 584 years.
> >
> > I believe that Jason built the Wireguard protocol on this predicate.

> Once again, just because project X did something doesn't mean it is
> acceptable here.

FWIW, from a design perspective, we try to operate under the
assumption that there are well understood architectural predicates
that secure systems can be built on.

For example, the statistical infeasibility of predicting a large
number generated by a random number generator with known numerical
characteristics or the lack of a direct solution to the discrete
logarithm problem.

We bin the chronological infeasibility of wrapping a 64-bit counter in
the same bucket, perhaps that is an oversight on our part.

> > We believe the second series will fully address this issue, without
> > using nonces, for whatever that is worth.  We can reserve further
> > discussion once that code is available and submitted for review.

> I mentioned this above, but please ensure the authentication approach
> is well documented.

It will be explained in detail.

> > > > > Frankly, I also wonder how a system would perform with an external
> > > > > modeler, indepdent of the issues with non-blocking hooks.  How does
> > > > > the system perform with every blockable LSM hook invocation
> > > > > potentially blocking on a response from userspace?  Or with the COE
> > > > > being somewhat coarse, does the trajectory/policy populate itself
> > > > > quickly?
> > > >
> > > > One obviously experiences a latency hit in going to userspace, by
> > > > definition, implementing security always has an associated resource
> > > > cost.  So, once again, this comes down to a cost/benefit analysis.
> > > >
> > > > As a Gedanken exercise, consider the value proposition of a Linux
> > > > based RTU, or other device, controlling infrastructure that can only
> > > > execute security relevant events that are guaranteed to be known good
> > > > by an external co-processor that is only accessible as a security
> > > > oracle.
> > > >
> > > > Given that frame of reference.
> > > >
> > > > Time for a userspace or SGX based TMA transaction is running around
> > > > 890 micro-seconds.
> > > >
> > > > Going to a TMA based in a Xen stubdomain implementation runs a bit
> > > > longer, probably around 940 micro-seconds or so.
> > > >
> > > > The micro-controller implementations are decidedly slower, with the
> > > > NRF52840-DONGLE clocking in at around 40 micro-seconds, but that is
> > > > strictly a CPU horsepower issue.
> > > >
> > > > All of this with the caveat that we have been focusing almost
> > > > exclusively on correctness and not optimizing performance.
> > > >
> > > > We've thought a bit, mainly on long walks with our Golden Retriever
> > > > Izzy, about the issue of building a kernel based policy cache with
> > > > externally modeled domains.  Given that the kernel does not, a-priori,
> > > > know what modeling algorithm a TMA might be using, we would need to
> > > > come up with a method of deterministically mapping a security event
> > > > description to a known good state point value.
> > > >
> > > > The other issue with all this is that with containerized workloads,
> > > > particularly micro-services, the rate of security event generation can
> > > > be surprisingly low.  Obviously this is also the case with embedded
> > > > implementations.
> > > >
> > > > Once again, what are you willing to pay to be safe?
> >
> > > For better or worse, when code is proposed for the upstream Linux
> > > Kernel it is subject to scrutiny from all manner of developers and
> > > users, with most being focused on their own pet projects/subsystems,
> > > not whatever new security promises you are providing.
> > >
> > > There have been patch(sets) and discussions relating to performance
> > > gains/losses on the other of tens of nanoseconds per operation.
> > >
> > > I think most of us in the security community are sympathetic to the
> > > question of "what are you willing to pay to be safe", but please
> > > understand that while we are understanding, there are others who will
> > > disagree not only with the performance cost tradeoff, but the very
> > > idea of safety you are promising.  My only suggestion is to be
> > > prepared, and be honest with the performance assessments of TSEM.
> >
> > We seem to be in agreement that there will always be a natural tension
> > between security and performance.  With TSEM our goal is to offer
> > choices.
> >
> > If an environment is sensitive to performance defects on the order of
> > tens of nanoseconds, it would seem unlikely that the architects or
> > administrators of such systems would be implementing integrity
> > controls of any kind.  In that context, we are no different than IMA
> > or IPE, it would seem highly unlikely that such environments are going
> > to tolerate a security solution involving a cryptographic checksum of
> > any type.

> Performance comparisons are always going to be relative.  In the
> tens-of-nanoseconds example that I'm thinking of, it wasn't about
> disabling security functionality, it was about optimizing the
> security functionality.

Given the current performance hit that speculative execution has given
us, with respect to indirect function calls, it would seem that the
LSM is going to be a problematic architecture, particularly with any
type of stacking.... :-)

> > > > > > +Event handlers that cannot be directly modeled, still consider, on
> > > > > > +entry, whether or not they are being called by an trusted or untrusted
> > > > > > +process.  As a result, an untrusted process will cause a non-modeled
> > > > > > +event to return a permissions violation in enforcing mode, even if the
> > > > > > +security event cannot be directly modeled.
> > > > > > +
> > > > > > +Security event modeling typically traps violations of trust by a COE
> > > > > > +with unmodeled characteristics that is attempting to access/execute a
> > > > > > +file or map memory as executable; or by a COE with known
> > > > > > +characteristics attempting to access or execute a CELL not prescribed
> > > > > > +by a model.  As a result, the impact of the ability to not directly
> > > > > > +model these events is lessened.
> > > > >
> > > > > ...
> > > > >
> > > > > > +Event modeling
> > > > > > +--------------
> > > > > > +
> > > > > > +TSEM security event modeling is based on the following functional
> > > > > > +definition for a security state point:
> > > > > > +
> > > > > > +Sp = SHA256(SHA256(EVENT_ID) || TASK_ID || SHA256(COE) || SHA256(CELL))
> > > >
> > > > > It appears that all of the hasing in TSEM is SHA256 based, you might
> > > > > want to consider making that a Kconfig option at the very least.
> > > >
> > > > That has been something that we have talked about as well.
> > > >
> > > > As I indicated previously, we really are minimalists, particularly
> > > > after watching IMA fight with issues surrounding algorithmic agility.
> > > >
> > > > It would be easy enough to make this configurable but does anyone see
> > > > SHA256 as not being useful in in this role anywhere in the next 10
> > > > years?
> >
> > > There are any number of reasons why one might need to select a
> > > different hash algorithm: legal constraints, security
> > > certifications, corporate policy.  I would strongly suggest making
> > > this configurable.
> >
> > Certainly sound and well reasoned advice, but the question then becomes
> > what hashes and what hash lengths, do you have any specific
> > recommendations?

> My recommendation is to make it configurable such that as algorithms
> are added, or removed, from the the kernel crypto code, they can be
> added to TSEM without much more than some Kconfig changes.

TSEM/V2 now can use any hash function that a kernel has available, it
was actually a remarkably straight forward implementation.

> > IMA currently has the options of SHA1, SHA256, SHA512, WHIRLPOOL512
> > and SM3; is this sufficient coverage, given that SHA1 in a new
> > implementation like TSEM probably doesn't make any sense?

> I can't honestly pretend to understand all of the different
> requirements which would dictate a user's choice of a hash algorithm.
> About the only thing I can say is that given a choice of stronger
> options, I wouldn't use SHA1 in a security context on any of the
> systems I maintain.

Nor would we, but it is now available if anyone wants it.... :-)

> > Our current inclination, for the initial release, in an embrace of
> > minimalisim, would be to make this a selectable option when a modeling
> > domain is setup, with the only selectable option being SHA256.  This
> > would place the onus on userspace to make the decision and doesn't
> > lock the kernel to an ABI.

> So long as it is configurable, and the API is designed to support
> different algorithms, it may be acceptable to only implement one
> algorithm in the initial implementation.  However, one of the easiest
> ways to ensure the specification and the implementation work correctly
> would be to support at least two algorithms in the initial
> implementation so that this ability can be tested.

We are now validating against multiple hash implementations, each with
multiple digest sizes, so hopefully this will lay the cryptographic
agility issue to rest.

> paul-moore.com

FWIW, we do appreciate your perspective on these issues, the
implementation has already improved as a result of your concerns.

Have a good remainder of the week.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
