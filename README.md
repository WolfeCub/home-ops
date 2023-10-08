<p align="center">
    <a id="image1" href="#image1"><img alt="k3s" src="https://raw.githubusercontent.com/cncf/artwork/master/projects/k3s/icon/color/k3s-icon-color.png" height="100"></a>
    <a id="image2" href="#image2"><img alt="flux" src="https://avatars.githubusercontent.com/u/52158677?s=280&v=4" height="100"></a>
    <a id="image3" href="#image3"><img alt="longhorn" src="https://raw.githubusercontent.com/cncf/artwork/master/projects/longhorn/icon/color/longhorn-icon-color.png" height="100"></a>
    <a id="image4" href="#image4"><img alt="calico" src="https://www.tigera.io/app/uploads/2021/06/Calico-logo-badge.svg" height="100"></a>
    <a id="image5" href="#image5"><img alt="kube-vip" src="https://kube-vip.io/images/kube-vip.png" height="100"></a>
    <a id="image6" href="#image6"><img alt="traefik" src="https://seeklogo.com/images/T/traefik-logo-337D318F44-seeklogo.com.png" height="100"></a>
    <a id="image7" href="#image7"><img alt="cert-manager" src="https://avatars.githubusercontent.com/u/39950598" height="100"></a>
    <a id="image8" href="#image8"><img alt="renovate" src="https://d4.alternativeto.net/6JboU3aXeS4A90Tlkij_5DUVX4QCY2R4J4dw3SqRSyo/rs:fill:280:280:0/g:ce:0:0/YWJzOi8vZGlzdC9pY29ucy9yZW5vdmF0ZV8xNTgxNDcucG5n.png" height="100"></a>
</p>

<h1 align="center">
  Kubernetes Gitops at Home(lab)
</h1>

This repository contains the configurations for my gitops managed kubernetes cluster. The technology stack is as follows:

- [k3s](https://k3s.io/) is the kubernetes distribution
- [flux2](https://fluxcd.io/) handles gitops (syncing the repository state to the cluster)
- [longhorn](https://longhorn.io/) for the storage provider
- [calico](https://www.tigera.io/project-calico/) for the network interface
- [kube-vip](https://kube-vip.io/) for the load balancer (running in ARP mode)
- [traefik](https://traefik.io/traefik/) provides the `LoadBalancer` and acts as a reverse proxy
- [cert-manager](https://cert-manager.io/) will use Let's Encrypt to provide certs to traefik for all my services
- [renovate](https://www.mend.io/free-developer-tools/renovate/) keeps an eye on the repo and automatically opens PRs to update helm and image versions
- [sops](https://github.com/mozilla/sops) is used to manage any cluster secrets
